function [DM,eigvals,Etot,Etime] = dmd(datamatrix)

    [M,N] = size(datamatrix);
    % construct paired matrices
    V1 = datamatrix(:,1:N-1);
    V2 = datamatrix(:,2:N);
    %perform SVD
    [U,Sigma,V] = svd(V1,'econ');
    % low dimensional estimate of A operator = Ahat
    Ahat = U'*V2*V/Sigma;
    % find eigenvals of Ahat
    [eigvecs,eigvals] = eig(Ahat,'vector');
    % if imag<eps, make real (accounts for numerical error in eigenval calc)
    eigvals(abs(imag(eigvals))<eps) = real(eigvals(abs(imag(eigvals))<eps));
    %project eigenvectors onto POD modes to get DMD modes
    DM = U*eigvecs;
    % construct time evolution matrix
    Vand = fliplr(vander(eigvals));
    %calculate dynamic mode weights
    d = (DM*diag(eigvals))\V2(:,1);
    % multiply dynamic modes by their weight factors
    DM = DM*diag(d);

    % calculate RMS energy of each mode over the entire time series
    Etime=zeros(N-1);
    for i=1:N-1
        Etime(i,:) = sqrt(sum((abs(DM(:,i)*Vand(i,:))).^2,1));
    end
    Etot = sum(Etime,2);

    % rank modes by RMS energy content
    [Etot,I] = sort(Etot,'descend');
    eigvals = eigvals(I);
    DM = DM(:,I);
    Etime = Etime(I,:);
end
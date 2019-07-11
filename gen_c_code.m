
cfg=coder.config('lib');
cfg.DynamicMemoryAllocation = 'Off';
cfg.InlineThreshold = 500;


codegen -c -rowmajor -config cfg -singleC etemp_interpolate1d -args {rand(8,32)}	

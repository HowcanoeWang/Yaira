max.layer='y_rank';
if y_direction>0
    y_rank='Max';
else
    y_rank='max.size+1-Max';
end
eval(['max.size=size(' sample_name '.Kind{sample_kind,3},1);'])
med.layer='x_rank';
if x_direction>0
    x_rank='Med';
else
    x_rank='med.size+1-Med';
end
eval(['med.size=size(' sample_name '.Kind{sample_kind,2},1);'])
min.layer='z_rank';
if z_direction>0
    z_rank='Min';
else
    z_rank='min.size+1-Min';
end
eval(['min.size=size(' sample_name '.Kind{sample_kind,4},1);'])
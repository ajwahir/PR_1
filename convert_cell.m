function cell_data=convert_cell(data,len)
    cell_data={};
    prev=1;
    for ii=1:length(len)
        cell_data{ii,1}=data(prev:prev+len(ii)-1);
        prev=prev+len(ii);
    end
end
    

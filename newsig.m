%��һ��
% file_path = 'E:\ƣ�ͼ����ش���\ƣ�ͼ���һ������\';
% save_path = 'E:\ƣ�ͼ����ش���\ƣ�ͼ���һ������\selected\dataAndLabel\';
% idx_file = {'hzw-yundong-selected_idx.mat','ljx-yundong-selected_idx.mat','wcj-yundong-selected_idx.mat','wcj-yundong-z-selected_idx.mat'};
%�ڶ���
file_path = 'E:\ƣ�ͼ����ش���\ƣ�ͼ��ڶ�������\��������\matdata\';
save_path = 'E:\ƣ�ͼ����ش���\ƣ�ͼ��ڶ�������\selected\';
idx_file = {'hyk-yundong2-selected_idx.mat','xdj-yundong2-selected_idx.mat'};

for i = 1 : length(idx_file)
    idx_name = idx_file{i};
    matdata_name = [idx_name(1:strfind(idx_name,'-select')-1) '-data.mat'];
    idx = importdata([save_path idx_file{i}]);
    sig = importdata([file_path matdata_name]);
    real_idx = [];
    for j = 1 : length(idx)
        real_idx = [real_idx idx(j)*1875-1874:idx(j)*1875];
    end
    data.sig = sig(:,real_idx);
    data.labels = zeros(1,length(idx));
    save([save_path 'dataAndLabel\' matdata_name],'data');
    
    disp([save_path matdata_name])
end

% labels=[zeros(1,16) ones(1,16) 2*ones(1,8)];
% wcj_good_labels=labels(selected_idx);
% wcj_good_sigs=[];
% for i=1:length(selected_idx)
% idx=selected_idx(i);
% cur_seg=data(:,idx*1875-1874:idx*1875);
% wcj_good_sigs=[wcj_good_sigs cur_seg];
% end


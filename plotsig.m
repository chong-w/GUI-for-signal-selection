function a=plotsig(sig,titles,cur_idx,handles)
% titles={'acc1','acc2','acc3','band\_resp','ecg','ppg','modu\_resp','modu\_ecg'};
% disp('plotsig')
    cur_seg = (cur_idx-1)*1875+1:cur_idx*1875;
    t = (0:1874)/125;
    axes(handles.uipanel1)
%     for i=1:8
%         subplot(8,1,i)
%         plot(sig(i,cur_seg))
%         title(titles{i});
%     end
    for i=4:8
        subplot(5,1,i-3)
        plot(sig(i,cur_seg))
        title(titles{i});
    end
%       subplot(4,1,1)
%       plot(t,sig(6,cur_seg));
%       title('ppg')
%       
%       psd = abs(fft(sig(6,cur_seg),4096));
%       psd = psd(1:501);
%       f = 125*(0:500)/4096;
%       subplot(4,1,2)
%       plot(f,psd);
%       title('ppg_psd')
%       
%       subplot(4,1,3)
%       plot(t,sig(7,cur_seg));
%       title('imp')
%       
%       subplot(4,1,4)
%       plot(t,sig(5,cur_seg));
%       title('ecg')
end
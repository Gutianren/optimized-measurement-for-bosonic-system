function [e, gs] = GetGroundEnergy(d, file)
    % get the ground state
    % Independent of the OGM process
%     [ad,a] = geta(d);
%     q0 = ad + a;
%     p0 = ad - a;
%     
%     % Get n
%     n = 0;
%     file = strcat(file,'.txt');
%     f1 = fopen(file);
%     while ~feof(f1)
%         fline = fgetl(f1);
%         datal = str2num(fline);
%         n = max(n,max(datal(1:length(datal)-1)));
%     end
%     fclose(f1);
%     
%     H_total = zeros(d^n, d^n);
%     
%     % potentials
%     f = fopen(file);
%     while ~feof(f)
%         fline = fgetl(f);
%         datal = str2num(fline);
%         j = length(datal)-1;
%         idx = datal(1:j);
%         k = datal(j+1);
%         
%         if j == 2 && idx(1) == idx(2)
%            i = idx(1);
%            w(i) = sqrt(2*k);
%         end
%         
%         H = zeros(d,d,n);
%         for i = 1 : n
%             H(:,:,i) = eye(d);
%         end
%         for i = 1 : j
%             H(:,:,idx(i)) = H(:,:,idx(i)) * q0 / sqrt(2*w(idx(i)));
%         end
%         
%         H_temp = H(:,:,1);
%         for i = 2 : n
%             H_temp = kron(H_temp, H(:,:,i));
%         end
%         H_total = H_total + H_temp * k;
%        
%     end
%     fclose(f);
%     % encoding the kinetic energy p^2/2
%     H = zeros(d,d,n);
%     for i = 1 : n
%         H(:,:,i) = eye(d);
%     end
%     for i = 1:n
%         H(:,:,i) = - p0 * p0 * w(i)/2 / 2;
%         H_temp = H(:,:,1);
%         for j = 2:n
%             H_temp = kron(H_temp, H(:,:,j));
%         end
%         H_total = H_total + H_temp;
%         H(:,:,i) = eye(d);
%     end
%     

    [H_total,w] = GetHamiltonian(d,file);
    [gs, e] = eig(H_total);
    e = diag(e);
    [e,idx] = sort(e);
    gs = gs(:,idx);
    e = e(1);
    gs = gs(:,1);
    
    ex1 = 0;
    for j = 1:d^3
        v = ToDinary(d,j-1,3);
        pd1 = 0;
        for k = 1:3
            pd1 = pd1 + w(k) * (v(k) + 1/2);
        end
        ex1 = ex1 + pd1 * abs(gs(j))^2;
    end
    fprintf('ex1=%f\n',ex1);
end
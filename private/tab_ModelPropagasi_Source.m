%
%Membandingkan Path Loss dengan Model Propagasi ITU dan COST231
%Oleh Ummu Handasah - NIM 120422011
%----------------------------------------------------------------


function tab_ModelPropagasi_Source(distance, frequency, dataTable, needToCompare)
    r=1:distance;
    f = frequency; %dalam MHz

    Litu = 20*log10(f)+ 10*3*log10(r)+9-28;                 %Menghitung Path Loss ITU
    Lfs = 32.4 + 20*log10(f) + 20*log10(r/1000);            %Menghitung Path Loss Free Space Loss

    a = 1;
    jlh_array = numel(r);
    kwi=zeros(jlh_array);
    Lcost = 0;
    while a <= jlh_array

        if r(a) < 2.4
           kwi(a) = 0;
        elseif  r(a) >= 2.7 &&  r(a) <= 7.2
           kwi(a) = 1;
        else 
          kwi(a) = 2;
        end
        Lcost = Lfs + kwi(a)*6.9;                           %Menghitung Path Loss COST231
        a = a+1;
    end

    EIRP = 22.5;    %Nilai sudah ditambah dengan masing masing gain dari penerima dan pemancar

    rssi=dataTable(:,5);
    rssi=transpose(rssi);
    L=EIRP - rssi;

    fontsize = 10;

    if(needToCompare)
        p = polyfit(L,r,2);
        Lreg = polyval(p,r);

        subplot (3,2,[5 6]);
        plot(r,Litu,'^b-');
        hold on;
        plot(r,Lcost,'xr-');
        hold on;
        plot(r,L,'om-');
        hold on;
        plot(r,Lreg,'+g-');
        grid on;
        hold on;
        title ('Perbandingan Path Loss', 'fontsize', fontsize, 'fontname', 'times new roman');
        xlabel ('Jarak, r (m)' ,'fontsize', fontsize, 'fontname', 'times new roman');
        ylabel ('Path Loss (dB)' ,'fontsize', fontsize, 'fontname', 'times new roman');
    end

    RSSI = EIRP - Litu;             %Menghitung RSSI Model ITU
    RsSi = EIRP - Lcost;            %Menghitung RSSI Model COST231

    subplot (3,2,2);
    plot(r,RSSI,'^b-');
    hold on;
    plot(r,RsSi,'xr-');
    grid on;
    hold on;
    title ('Perbandingan RSSI', 'fontsize', fontsize, 'fontname', 'times new roman');
    xlabel ('Jarak, r (m)' ,'fontsize', fontsize, 'fontname', 'times new roman');
    ylabel ('RSSI (dB)' ,'fontsize', fontsize, 'fontname', 'times new roman');

    subplot (3,2,[3 4]);
    plot(kwi,Lcost,'sr-');
    grid on;
    hold on;
    title ('Path Loss Fungsi Sekat', 'fontsize', fontsize, 'fontname', 'times new roman');
    xlabel ('kwi' ,'fontsize', fontsize, 'fontname', 'times new roman');
    ylabel ('Path Loss (dB)' ,'fontsize', fontsize, 'fontname', 'times new roman');

    subplot (3,2,1);
    plot(r,Litu,'^b-');
    hold on;
    plot(r,Lcost,'xr-');
    grid on;
    hold on;
    title ('Perbandingan Path Loss Model ITU dan COST231', 'fontsize', fontsize, 'fontname', 'times new roman');
    xlabel ('Jarak (meter)' ,'fontsize', fontsize, 'fontname', 'times new roman');
    ylabel ('Path Loss (dB)' ,'fontsize', fontsize, 'fontname', 'times new roman');

 

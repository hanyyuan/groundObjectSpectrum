function smoothFunction(filename)

 reflectance = importdata(filename);
    if reflectance(1,1)<390
        wavelengthBegin = 350;     
    else
        wavelengthBegin = 400;    
    end

% Get source data
wavelength = reflectance(:,1);
ref = reflectance(:,2);

    %% smooth goes here
    % remove extreme refs, <0, >1
    ind = find(ref>0&ref<1);
    wavelength  = wavelength(ind);
    ref = ref(ind);

    xq = wavelengthBegin:2500;
    xv = interp1(wavelength, ref, xq, 'nearest');
    xv0 = xv;

    % process wavelength 960:1013, 1825:1906,
    % bs = {960:1013,1825:1906, 1907:2500};  % 2001:2500,
    %% remove 
    bs = [1343,1428; 1780,1970];
    bsNum = size(bs, 2);
    for ib = 1:bsNum
        x=  bs(ib,:);
        xind = x-wavelengthBegin+1;
        tmp1 = xq(xind);
        tmp2 = xv(xind);
        p = polyfit(tmp1, tmp2, 1);
        tmp3 = bs(ib,1):bs(ib,2);

        y1 = polyval(p, tmp3);
        tmp3 = tmp3 -wavelengthBegin+1;
        xv(tmp3) = y1;
    end

    %% 1760:1980,
    bs = {960:1070,2061:2160, 2161:2260, 2261:2360};
    bsNum = size(bs, 2);
    for ib = 1:bsNum
        x=  bs{ib};
        xind = x-wavelengthBegin+1;
        tmp1 = xq(xind);
        tmp2 = xv(xind);
        p = polyfit(tmp1, tmp2, 4);
        y1 = polyval(p, tmp1);
        xv(xind) = y1;
    end
    bsp = {2320:2360,2361:2500};  % {2361:2500};
    x=  bsp{1};
    xind = x-wavelengthBegin+1;
    tmp1 = xq(xind);
    tmp2 = xv(xind);
    p = polyfit(tmp1, tmp2, 2);
    x=  bsp{2};
    xind = x-wavelengthBegin+1;
    tmp1 = xq(xind);
    tmp2 = xv(xind);
    y1 = polyval(p, tmp1);
    xv(xind) = y1;

    %% resmooth
    xv(1440-wavelengthBegin:1460-wavelengthBegin) = xv(1460-wavelengthBegin+1);
    % xv(1801-wavelengthBegin:1815-wavelengthBegin) = xv(1800-wavelengthBegin);
    % xv(1950-wavelengthBegin:1979-wavelengthBegin) = xv(1980-wavelengthBegin);
    bs = {920:990,1040:1100,1313:1373,1400:1460, 1790:1825, 1950:2010};
    bsNum = size(bs, 2);
    for ib = 1:bsNum
        x=  bs{ib};
        xind = x-wavelengthBegin+1;
        tmp1 = xq(xind);
        tmp2 = xv(xind);
        p = polyfit(tmp1, tmp2, 3);
        y1 = polyval(p, tmp1);
        xv(xind) = y1;
    end

xv=smooth(xv,20,'loess');
    %% write data
    fid=fopen(filename,'w','n','utf-8'); %¡ã?utf-8??????¡¤??¨°????
    for j = 1:size(xq,2)
        fprintf(fid,'%d\t%0.6f\r\n', xq(j), xv(j));
    end
    fclose(fid);
end


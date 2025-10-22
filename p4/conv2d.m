function output=conv2d(img, K)
    img = double(img);
    [img_rows, img_cols] = size(img);
    kernel_size = length(K);
    padding = floor(kernel_size / 2);
    padded = padarray(img,[padding padding],'replicate');
    
    output = zeros(img_rows, img_cols);

    for i = 1:img_rows
        for j = 1:img_cols
            region = padded(i:i+kernel_size-1, j:j+kernel_size-1);
            output(i, j) = sum(sum(region .* K));
        end
    end
    output = uint8(output);
end
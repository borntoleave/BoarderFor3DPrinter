function [ output_args ] = filL( RawImg )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

filled=imfill(rgb2gray(imread(RawImg))==255);
 imshow(filled)
end


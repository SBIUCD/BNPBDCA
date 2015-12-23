function [Ref] = GenerateDataset_PCAbased( min,interval)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
Ref=min+rand(size(min)).*interval;

end


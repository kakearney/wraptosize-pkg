function txt = wraptosize(str, szstr, varargin)
%WRAPTOSIZE Wraps text to a certain size
%
% txt = wraptosize(str, szstr)
% txt = wraptosize(str, szstr, param, val, ...)
%
% This functions like textwrap, except instead of wrapping text to fit in a
% uicontrol, text is wrapped to the given size area.
%
% Input variables:
%
%   str:    character array
%
%   szstr:  string listing width and height of text-wrapping area, in a
%           format similar to setpos.m format, e.g '1in 0.5in'.
%
% Optional input variables (passed as paramter/value pairs):
%
%   style:  'cell' or 'char', determines whether output is a cell array of
%           strings or a single string with \n indicating line wraps.
%           ['cell']
%
%   tprop:  cell array of parameter/value pairs to be applied to the text
%           (fontsize, fontname, etc)
%
% Output variables:
%
%   text:   wrapped text.  This is either a cell array of strings or a
%           character array including \n characters, depending of style.

% Copyright 2009 Kelly Kearney

p = inputParser;

p.addParameter('style', 'cell');
p.addParameter('tprop', {});
p.parse(varargin{:});
Opt = p.Results;


% Wrap text in nodes

hf = figure('visible', 'off');
ht = uicontrol('style', 'text', Opt.tprop{:});
pos = sprintf('# # %s', szstr);
setpos(ht, pos);

str = {str};

txt = textwrap(ht, str);

close(hf);

if strcmp(Opt.style, 'char')
    txt = sprintf('%s\\n', txt{:});
    txt = txt(1:end-2);
end




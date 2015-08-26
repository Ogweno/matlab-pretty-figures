function parsedObject = optionParser(varargin)
%OPTIONPARSER parses options supplied to main script. 

parsedObject = inputParser;

%===============================================================================
% Common options
%===============================================================================
parsedObject.addParameter('aspectRatio',1.618,@isnumeric); %Default ratio is Golden Ratio.
parsedObject.addParameter('drawGrid',true,@islogical);
parsedObject.addParameter('drawBox',true,@islogical);
parsedObject.addParameter('ticksFontSize',14,@isnumeric);

%===============================================================================
% export_fig options
%===============================================================================
validFigExtention = {'pdf','eps','png','tiff','jpg','bmp'}; 
defaultFigExtention = 'pdf';
checkFigExtention = @(x) any(validatestring(x,validFigExtention));
parsedObject.addParameter('exportFigExtention',defaultFigExtention,checkFigExtention);

%===============================================================================
%TikZ options
%===============================================================================

%Legend number style
validNumberStyle = {'fixed','sci'}; 
defaultNumberStyle = 'fixed';
checkNumberStyle = @(x) any(validatestring(x,validNumberStyle));

parsedObject.addParameter('figureHeight',3,@isnumeric);
parsedObject.addParameter('isStrict',false,@islogical);
parsedObject.addParameter('showInfo',false,@islogical);
parsedObject.addParameter('showWarnings',true,@islogical);
parsedObject.addParameter('strictFontSize',false,@islogical);
parsedObject.addParameter('noSize',true,@islogical);
parsedObject.addParameter('allowScaling',false,@islogical);
parsedObject.addParameter('moveXScale',true,@islogical);
parsedObject.addParameter('extraAxisOptions',{},@iscell);
parsedObject.addParameter('numberStyle',defaultNumberStyle,checkNumberStyle);

%Parsing options.
parsedObject.CaseSensitive = false;
parsedObject.KeepUnmatched = true;

%Parse the inputs.
parsedObject.parse(varargin{:});
end

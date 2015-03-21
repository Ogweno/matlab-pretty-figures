function parsedObject = optionParser(varargin)
%OPTIONPARSER parses options supplied to main script. 

parsedObject = inputParser;

%===============================================================================
% Common options
%===============================================================================
parsedObject.addParameter('aspectRatio',1.618,@isnumeric); %Default ratio is Golden Ratio.
parsedObject.addParameter('drawGrid',true,@isbool);
parsedObject.addParameter('drawBox',true,@isbool);
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
parsedObject.addParameter('isStrict',false,@isbool);
parsedObject.addParameter('showInfo',false,@isbool);
parsedObject.addParameter('showWarnings',true,@isbool);
parsedObject.addParameter('strictFontSize',false,@isbool);
parsedObject.addParameter('noSize',true,@isbool);
parsedObject.addParameter('allowScaling',false,@isbool);
parsedObject.addParameter('moveXScale',true,@isbool);
parsedObject.addParameter('extraAxisOptions',{},@iscell);
parsedObject.addParameter('numberStyle',defaultNumberStyle,checkNumberStyle);

%Parsing options.
parsedObject.CaseSensitive = false;
parsedObject.KeepUnmatched = true;

%Parse the inputs.
parsedObject.parse(varargin{:});
end

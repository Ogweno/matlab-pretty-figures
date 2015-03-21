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

%Legend direction
validLegendDirection = {'horiz','vert'};
defaultLegendDirection = ''; 
checkLegendDirection = @(x) any(validatestring(x,validLegendDirection));

%Legend location
validLegendLocation = {'North','South','East','West', ...
                    'NorthOutside','SouthOutside', 'EastOutside','WestOutSide',...
                    'NorthEast','NorthWest',...
                    'SouthEast','SouthWest'};
defaultLegendLocation = 'NorthEast';
checkLegendLocation = @(x) any(validatestring(x,validLegendLocation));

parsedObject.addParameter('figureHeight',3,@isnumeric);
parsedObject.addParameter('isStrict',false,@isbool);
parsedObject.addParameter('showInfo',false,@isbool);
parsedObject.addParameter('showWarnings',false,@isbool);
parsedObject.addParameter('strictFontSize',false,@isbool);
parsedObject.addParameter('noSize',true,@isbool);
parsedObject.addParameter('allowScaling',false,@isbool);
parsedObject.addParameter('moveXScale',true,@isbool);
parsedObject.addParameter('extraAxisOptions',{},@iscell);
parsedObject.addParameter('numberStyle',defaultNumberStyle,checkNumberStyle);
parsedObject.addParameter('legendDirection',defaultLegendDirection,checkLegendDirection);
parsedObject.addParameter('legendLocation',defaultLegendLocation,checkLegendLocation);

%Parsing options.
parsedObject.CaseSensitive = false;
parsedObject.KeepUnmatched = true;

%Parse the inputs.
parsedObject.parse(varargin{:});
end

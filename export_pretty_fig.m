function export_pretty_fig(fileName,figureHandle,varargin)
%EXPORT_PRETTY_FIG exports the figures in a pretty format for inclusion in LaTeX documents.

%Parse all the options
extraOptions = optionParser(varargin{:});

%===============================================================================
% Manipulate the figure
%===============================================================================

%Options for figure
aspectRatio   = extraOptions.Results.aspectRatio;
drawGrid      = extraOptions.Results.drawGrid;
drawBox       = extraOptions.Results.drawBox;
ticksFontSize = extraOptions.Results.ticksFontSize;

%Manipulate the figure.    
figureAxes = get(figureHandle,'CurrentAxes');

pbaspect(figureAxes,[aspectRatio 1 1]);

if drawGrid
    grid on; set(figureAxes,'gridlinestyle','-');
end

if drawBox   
    box on;
end

set(figureHandle,'Color','w'); %Set the background to white
set(figureAxes,'FontSize', ticksFontSize);
set(figureAxes,'FontName','Times New Roman');

%===============================================================================
% Export using export_fig
%===============================================================================

%Options for export_fig
exportFigExtention = extraOptions.Results.exportFigExtention;

%Save the PDF
pdfFile = [fileName '.' exportFigExtention];    
export_fig(pdfFile,figureHandle);

%===============================================================================
% Export to a TikZ plot
%===============================================================================

%Options for Tikz
tikz.file = [fileName '.tikz'];
tikz.figureHeight     = extraOptions.Results.figureHeight     ;   
tikz.isStrict         = extraOptions.Results.isStrict         ; 
tikz.showInfo         = extraOptions.Results.showInfo         ; 
tikz.showWarnings     = extraOptions.Results.showWarnings     ; 
tikz.strictFontSize   = extraOptions.Results.strictFontSize   ; 
tikz.noSize           = extraOptions.Results.noSize           ; 
tikz.allowScaling     = extraOptions.Results.allowScaling     ; 
tikz.numberStyle      = extraOptions.Results.numberStyle      ; 
tikz.moveXScale       = extraOptions.Results.moveXScale       ; 
tikz.extraAxisOptions = extraOptions.Results.extraAxisOptions ;
tikz.legendDirection  = extraOptions.Results.legendDirection  ;
tikz.legendLocation   = extraOptions.Results.legendLocation   ;

%Default extraAxisOptions.
tikz.extraAxisOptions = [tikz.extraAxisOptions, ...
    {'ylabel near ticks' ,  ...         %Make y-labels appear near axis
     'xlabel near ticks' ,  ...         %Make x-labels appear near axis
     'tick scale binop=\times' ...      %Use scientific notation to be 3x10^5, not 3.10^5
    }];

m2tOptions = {};

%Add option of height and weight if required.
if ~tikz.noSize
    m2tOptions = [m2tOptions ...
                 {'height',sprintf('%din',tikz.figureHeight),           ...
                  'width',sprintf('%din',aspectRatio*tikz.figureHeight)}...
                  ];
else
    tikz.extraAxisOptions = [tikz.extraAxisOptions 'scale only axis'];
end

%Should the ticks be scaled. 
if ~tikz.allowScaling
    tikz.extraAxisOptions = [tikz.extraAxisOptions 'scaled ticks=false'];
end

%Number style of tikz labels.
switch tikz.numberStyle
  case 'fixed'
    tikz.extraAxisOptions = [tikz.extraAxisOptions 'ticklabel style={/pgf/number format/fixed}'];
  case 'sci'
    tikz.extraAxisOptions = [tikz.extraAxisOptions ...
                        ['ticklabel style={/pgf/number format/sci,' ...
                        '/pgf/number format/sci generic={mantissa sep=\times,exponent={{10}^{####1}} ' ...
                        '}}']]; 
  otherwise
     %Do nothing.
end

%Make the location of scaling of x-axis pretty.
if tikz.moveXScale
    tikz.extraAxisOptions = [tikz.extraAxisOptions ...
                        ['every x tick scale label/.style={at={(1,0)},xshift=4pt,anchor=south ' ...
                        'west,inner sep=0pt}']];
end

%Add legend direction.
switch tikz.legendDirection
  case 'horiz'
     tikz.extraAxisOptions = [tikz.extraAxisOptions ...
                         'legend columns=-1'];
  case 'vert'
     tikz.extraAxisOptions = [tikz.extraAxisOptions ...
                         'legend columns=1'];
  otherwise
    %Do nothing.
end

%Add legend location
switch tikz.legendLocation
  case 'North'
    tikz.extraAxisOptions = [tikz.extraAxisOptions 'legend style={at={(0.5,0.97)},anchor=north}'];
  case 'South'
    tikz.extraAxisOptions = [tikz.extraAxisOptions 'legend style={at={(0.5,0.03)},anchor=south}'];
  case 'East'
    tikz.extraAxisOptions = [tikz.extraAxisOptions 'legend style={at={(0.97,0.5)},anchor=east}'];
  case 'West'
    tikz.extraAxisOptions = [tikz.extraAxisOptions 'legend style={at={(0.03,0.05)},anchor=west}'];
  case 'NorthOutside'
    tikz.extraAxisOptions = [tikz.extraAxisOptions 'legend style={at={(0.5,1.03)},anchor=south}'];
  case 'SouthOutside'
    tikz.extraAxisOptions = [tikz.extraAxisOptions 'legend style={at={(0.5,-0.1)},anchor=north}'];  
  case 'EastOutside'
    tikz.extraAxisOptions = [tikz.extraAxisOptions 'legend style={at={(1.03,0.5)},anchor=west}'];
  case 'WestOutside'
    tikz.extraAxisOptions = [tikz.extraAxisOptions 'legend style={at={(-0.1,0.5)},anchor=east}'];
  case 'NorthEast'
    tikz.extraAxisOptions = [tikz.extraAxisOptions 'legend pos=north east'];
  case 'NorthWest'
    tikz.extraAxisOptions = [tikz.extraAxisOptions 'legend pos=north west'];
  case 'SouthEast'
    tikz.extraAxisOptions = [tikz.extraAxisOptions 'legend pos=south east'];
  case 'SouthWest'
    tikz.extraAxisOptions = [tikz.extraAxisOptions 'legend pos=south west'];
  otherwise
    %Do nothing
end

%Pass the options to matlab2tikz
m2tOptions = [m2tOptions  ...
    { 'filename',         tikz.file,             ...
      'figurehandle',     figureHandle,          ...
      'showInfo',         tikz.showInfo,         ...
      'strict',           tikz.isStrict,         ...
      'extraAxisOptions', tikz.extraAxisOptions, ...
      'strictFontSize',   tikz.strictFontSize,   ...
      'noSize',           tikz.noSize,           ...
      'showWarnings',     tikz.showWarnings      ...
    }];

%Save the tikz file
matlab2tikz(m2tOptions{:});

end

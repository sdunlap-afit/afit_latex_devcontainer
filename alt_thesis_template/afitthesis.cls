% This material is declared a work of the United States Government and is not
% subject to copyright protection in the United States.
%
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and sell copies
% of the Software, and to permit persons to whom the Software is furnished to do
% so, subject to the following conditions:
%
% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.
%
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE.
% ------------------------------------------------------------------------------
% Author: David Woodburn
% Description: LaTeX class implementing the Style Guide for AFIT Theses,
%   Dissertations, and Graduate Research Papers. Distribution Statement A.
%   Approved for public release: distribution is unlimited.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{afitthesis}[2025/03/31 AFIT Theses and Dissertations]
\def\@version{20250331}

% Key-value option handling
\RequirePackage{kvoptions} % For key-value option parsing
\SetupKeyvalOptions{family=thesisbib, prefix=thesisbib@}
\DeclareStringOption[apa]{style} % Default style is 'apa'
\DeclareStringOption[nty]{sorting} % Default style is 'apa'
\ProcessKeyvalOptions*

% Process class options.
\def\@fontsizeopt{11pt} % Default font size.
\DeclareOption{10pt}{\def\@fontsizeopt{10pt}}
\DeclareOption{11pt}{\def\@fontsizeopt{11pt}}
\DeclareOption{12pt}{\def\@fontsizeopt{12pt}}

\newif\ifdefineul\defineultrue
\DeclareOption{noul}{\defineulfalse}

\newif\ifoldmargins\oldmarginsfalse
\DeclareOption{oldmargins}{\oldmarginstrue} % Use old-style margins.

\newif\ifshowguides\showguidesfalse
\DeclareOption{showguides}{\showguidestrue} % Show red lines for spacings.

\newif\ifinternal\internalfalse
\DeclareOption{internal}{\internaltrue} % Exclude external-facing pages.

\newif\ifreview\reviewfalse
\DeclareOption{review}{\reviewtrue} % Put into review mode (line numbers).

\DeclareOption{twocolumn}{\OptionNotUsed} % don't allow two column style
\DeclareOption{table}{\PassOptionsToPackage{table}{xcolor}} % \cellcolor

\DeclareOption*{\PackageWarning{afitthesis}{Unknown '\CurrentOption'}}
\ProcessOptions\relax
\LoadClass[letterpaper, onecolumn, \@fontsizeopt, openany]{book}

% Require packages.
\RequirePackage[T1]{fontenc} % use 8-bit fonts
\RequirePackage{geometry} % page dimensions and margins
\RequirePackage{setspace} % control the line spacing (e.g. doublespacing)
\RequirePackage{float} % custom floats
\RequirePackage{flafter} % (builtin) floats after their definitions
\RequirePackage{caption} % customize captions without undoing hyperref
\RequirePackage{adjustbox} % rotate boxes
\RequirePackage{amsmath} % better math
\RequirePackage{amsfonts} % better math fonts
\RequirePackage{bm} % bold math (must be after amsmath)
\RequirePackage{listings} % code and algorithms
\RequirePackage{matlab-prettifier} % better MATLAB code formatting
\RequirePackage{upquote} % use upright single quotes in verbatim
\RequirePackage{array} % custom column alignment types
\RequirePackage{enumitem} % custom lists and list spacing
\RequirePackage{etoolbox} % modify existing environments
\RequirePackage[pagewise, left, modulo]{lineno} % include line numbers
\RequirePackage{totalcount} % to count figures and tables
\RequirePackage{pgfplots} % plots (includes xcolor, graphicx, tikz)
\RequirePackage{pdfpages} % include whole pdf documents
\RequirePackage{hyperref} % hyperlinks (before glossaries)
\RequirePackage[acronym]{glossaries} % glossaries and acronyms
\RequirePackage[ % automatic bibliographies
    style=numeric,
    sorting=\thesisbib@sorting,
    backend=biber]{biblatex}

% PGF Plot configuration
\pgfplotsset{compat=newest}

% ----------------------
% Added content features
% ----------------------

% Standard math macros
\ifdefineul
    \newcommand{\ul}[1] % vectors
        {{}\mkern1mu\underline{\mkern-1mu#1\mkern-1mu}\mkern1mu}
\fi
\DeclareSymbolFont{euler}{U}{eur}{m}{n} % symbol font
\DeclareMathSymbol{\PI}{\mathord}{euler}{25} % up pi

% Convenience macros
\DeclareMathOperator{\sgn}{sgn}             % sign function
\DeclareMathOperator{\tr}{tr}               % trace of a matrix
\DeclareMathOperator{\adj}{adj}             % adjugate of a matrix
\DeclareMathOperator*{\argmax}{arg\,max}    % argmax operator
\DeclareMathOperator*{\argmin}{arg\,min}    % argmin operator
\newcommand{\abs}[1]{\left\lvert#1\right\rvert} % absolute value
\newcommand{\norm}[1]{\left\lVert#1\right\rVert} % vector or matrix norm
\newcommand{\ssm}[1]{[#1]_{\rule{0pt}{1.38ex}\times}} % skew symmetric matrix
\newcommand{\diff}[2]{\frac{\mathrm{d}{#1}}{\mathrm{d}{#2}}} % derivative
\newcommand{\piff}[2]{\frac{\partial{#1}}{\partial{#2}}} % partial derivative
\newcommand{\EE}[2]{\ensuremath{{{#1}\!\times\!10^{#2}}}} % scientific notation
\newcommand{\rom}[1]{\uppercase\expandafter{\romannumeral #1\relax}}

% Upright math letters
\newcommand{\upc}[1][]{\mathrm{c}_{#1}}     % abbreviated cosine
\newcommand{\ups}[1][]{\mathrm{s}_{#1}}     % abbreviated sine
\newcommand{\upt}[1][]{\mathrm{t}_{#1}}     % abbreviated tangent
\newcommand{\upd}{\mathrm{d}}               % differential operator
\newcommand{\upe}{\mathrm{e}}               % Euler's number
\newcommand{\upi}{\mathrm{i}}               % imaginary number
\newcommand{\upj}{\mathrm{j}}               % imaginary number
\newcommand{\upk}{\mathrm{k}}               % quaternion number

% Increase maximum number of matrix columns.
\setcounter{MaxMatrixCols}{20}

% Define custom table column types (array package) and spacings.
\newcolumntype{L}[1]{>{\raggedright\arraybackslash}p{#1}}
\newcolumntype{C}[1]{>{\centering\arraybackslash}p{#1}}
\newcolumntype{R}[1]{>{\raggedleft\arraybackslash}p{#1}}
\setlength{\tabcolsep}{1ex} % spacing between columns of a table

% Custom colors (xcolor package)
\definecolor{blue}{RGB}{76,76,255}      % 4c4cff
\definecolor{azure}{RGB}{0,128,255}     % 0080ff
\definecolor{cyan}{RGB}{0,209,209}      % 00d1d1
\definecolor{green}{RGB}{15,180,0}      % 0fb400
\definecolor{lime}{RGB}{180,216,0}      % b4d800
\definecolor{yellow}{RGB}{255,191,0}    % ffbf00
\definecolor{orange}{RGB}{255,128,0}    % ff8000
\definecolor{red}{RGB}{255,38,38}       % ff2626
\definecolor{magenta}{RGB}{255,0,255}   % ff00ff
\definecolor{purple}{RGB}{153,51,255}   % 9933ff

% Clickable mailto email addresses
\newcommand{\mailto}[1]{\href{mailto:#1}{\nolinkurl{#1}}}

% TikZ pictures, predefined for efficient reuse
\tikzset{
    afitcrest/.pic={
        % (-0.866,-0.866) to (0.866,0.866)
        \definecolor{crestdark}{RGB}{127,127,127}
        \definecolor{crestlight}{RGB}{191,191,191}
        % Ribbon
        \draw[crestlight, very thick, line cap=round, fill=white] (-0.61,-0.04)
            .. controls (-0.62,-0.01) and (-0.64,0.092) .. (-0.72,0.092)
            .. controls (-0.75,0.092) and (-0.78,0.06) .. (-0.78,0.025)
            .. controls (-0.78,-0.05) and (-0.866,-0.13) .. (-0.866,-0.175)
            .. controls (-0.866,-0.22) and (-0.82,-0.24) .. (-0.79,-0.235)
            (0.79,-0.235)
            .. controls (0.82,-0.24) and (0.866,-0.22) .. (0.866,-0.175)
            .. controls (0.866,-0.13) and (0.78,-0.05) .. (0.78,0.025)
            .. controls (0.78,0.06) and (0.75,0.092) .. (0.72,0.092)
            .. controls (0.64,0.092) and (0.62,-0.01) .. (0.61,-0.04);
        \draw[crestlight, very thick, line cap=round, fill=white]
            (-0.74,-0.04) -- (-0.703,0.025)
            .. controls (-0.6,-0.07) and (-0.795,-0.16) .. (-0.795,-0.28)
            .. controls (-0.795,-0.4) and (-0.652,-0.53) .. (-0.47,-0.619)
            .. controls (-0.288,-0.709) and (-0.15,-0.735) .. (0,-0.866)
            .. controls (0.15,-0.735) and (0.288,-0.709) .. (0.47,-0.619)
            .. controls (0.652,-0.53) and (0.795,-0.4) .. (0.795,-0.28)
            .. controls (0.795,-0.16) and (0.6,-0.07) .. (0.703,0.025) --
            (0.74,-0.04);
        \draw[crestlight, very thick, line cap=round] (-0.78,0.025)
            .. controls (-0.78,-0.04) and (-0.69,-0.09) .. (-0.676,-0.018)
            (0.78,0.025)
            .. controls (0.78,-0.04) and (0.69,-0.09) .. (0.676,-0.018);
        % Shield background
        \fill[crestlight, draw=crestdark, thick]
            (-0.678,0.684) -- (-0.5,0.866) -- (0.5,0.866) -- (0.678,0.684)
            .. controls (0.6,0.58) and (0.565,0.43) .. (0.565,0.308)
            .. controls (0.565,0.12) and (0.622,0.0) .. (0.622,-0.1)
            .. controls (0.622,-0.42) and (0.15,-0.41) .. (0,-0.61)
            .. controls (-0.15,-0.41) and (-0.622,-0.42) .. (-0.622,-0.1)
            .. controls (-0.622,0.0) and (-0.565,0.12) .. (-0.565,0.308)
            .. controls (-0.565,0.43) and (-0.6,0.58) .. (-0.678,0.684) -- cycle;
        % Shield foreground
        \fill[crestdark]
            (-0.56,0.0)
            .. controls (-0.51,0.2) and (-0.493,0.5) .. (-0.625,0.676)
            -- (-0.48,0.825) -- (0.48,0.825) -- (0.625,0.676)
            .. controls (0.493,0.5) and (0.51,0.2) .. (0.56,0) % top
            {[xshift=0.588cm]
            .. controls (-0.038,0) and (-0.063,-0.01) .. (-0.063,-0.03) % cave
            .. controls (-0.068,-0.05) and (-0.035,-0.06)
            .. (-0.035,-0.08) % vex
            .. controls (-0.035,-0.1) and (-0.06,-0.11)
            .. (-0.098,-0.11)} % bottom
            \foreach \xs in {0.392cm, 0.196cm, 0cm, -0.196cm, -0.392cm}{
                [xshift=\xs]
                .. controls (0.06,-0.11) and (0.035,-0.1)
                .. (0.035,-0.08) % vex
                .. controls (0.035,-0.06) and (0.068,-0.05)
                .. (0.063,-0.03) % cave
                .. controls (0.063,-0.01) and (0.038,0) .. (0,0) % top
                .. controls (-0.038,0) and (-0.063,-0.01)
                .. (-0.063,-0.03) % cave
                .. controls (-0.068,-0.05) and (-0.035,-0.06)
                .. (-0.035,-0.08) % vex
                .. controls (-0.035,-0.1) and (-0.06,-0.11)
                .. (-0.098,-0.11) % bottom
            }
            [xshift=-0.588cm]
            .. controls (0.06,-0.11) and (0.035,-0.1) .. (0.035,-0.08) % vex
            .. controls (0.035,-0.06) and (0.068,-0.05) .. (0.063,-0.03) % cave
            .. controls (0.063,-0.01) and (0.038,0) .. (0.028,0); % top
        % Gear
        \def\ygear{0.4125cm}
        \fill[crestlight, yshift=\ygear]
            (-4.875:0.26)
            \foreach \i in {0,1,...,15} {%
                [rotate=(22.5*\i-5.625)] arc (0.75:10.5:0.26) --
                (12:0.3) arc (12:21.75:0.3) -- (23.25:0.26)
            };
        % Circle
        \draw[thick, crestdark, yshift=\ygear]
            (0,0) circle (0.2);
        % Outer orbits
        \begin{scope}[yshift=\ygear]
            \foreach \i in {0, 30, 60, 90, 120, 150}{
                \draw[thick, crestdark, rotate=\i]
                    (0,0) circle (0.17 and 0.05);
            }
        \end{scope}
        % Inner orbits
        \begin{scope}[yshift=\ygear]
            \foreach \i in {45, 135}{
                \draw[thick, crestdark, rotate=\i]
                    (0,0) circle (0.04 and 0.015);
            }
        \end{scope}
        % Lightening
        \foreach \xf/\yf in {1/1, 1/-1, -1/1, -1/-1}{
            \begin{scope}[yshift=\ygear, xscale=\xf, yscale=\yf]
                \fill[crestlight, very thin]
                    (0.176,0.2) -- (0.186,0.217) -- (0.295,0.321) --
                    (0.303,0.249) -- (0.362,0.306) -- (0.318,0.310) --
                    (0.442,0.380) -- (0.392,0.240) -- (0.382,0.289) --
                    (0.287,0.170) -- (0.278,0.250) -- (0.217,0.186) --
                    (0.2,0.176) arc (41.35:48.65:0.2664);
            \end{scope}
        }
        % Letters
        \fontsize{10pt}{10pt}\fontfamily{ptm}\selectfont
        \begin{scope}[crestdark]
            \node[rotate=-62, yscale=1.9] at (-0.681,-0.278){A};
            \node[rotate=-50, yscale=1.9] at (-0.642,-0.333){F};
            \node[rotate=-37, yscale=1.9] at (-0.565,-0.412){I};
            \node[rotate=-33, yscale=1.9] at (-0.520,-0.443){N};
            \node[rotate=-28, yscale=1.9] at (-0.467,-0.476){S};
            \node[rotate=-24, yscale=1.9] at (-0.415,-0.503){T};
            \node[rotate=-21, yscale=1.9] at (-0.370,-0.523){I};
            \node[rotate=-22, yscale=1.9] at (-0.320,-0.544){T};
            \node[rotate=-22, yscale=1.9, xslant=-0.25]
                at (-0.251,-0.572){U};
            \node[rotate=-26, yscale=1.9, xslant=-0.65]
                at (-0.182,-0.605){T};
            \node[rotate=-33, yscale=1.85, xslant=-1.10]
                at (-0.120,-0.642){E};
            \node[rotate=-41, xscale=1.2, yscale=1.72, xslant=-1.30]
                at (-0.027,-0.708){O};
            \node[rotate=41, xscale=1.5, yscale=1.65, xslant=0.95]
                at (0.035,-0.700){F};
            \node[rotate=37, xscale=1.35, yscale=1.7, xslant=0.85]
                at (0.134,-0.633){T};
            \node[rotate=30, xscale=1.19, yscale=1.95, xslant=0.65]
                at (0.204,-0.593){E};
            \node[rotate=12, yscale=2.05] at (0.262,-0.563){C};
            \node[rotate=20, yscale=1.95] at (0.327,-0.538){H};
            \node[rotate=23, yscale=1.95] at (0.398,-0.510){N};
            \node[rotate=30, yscale=1.9] at (0.467,-0.477){O};
            \node[rotate=32, yscale=1.9] at (0.529,-0.439){L};
            \node[rotate=38, yscale=1.9] at (0.585,-0.398){O};
            \node[rotate=51, yscale=1.9] at (0.640,-0.342){G};
            \node[rotate=63, yscale=1.9] at (0.680,-0.276){Y};
        \end{scope}
        % Signature
        \node[rotate=24, scale=0.5, crestlight, opacity=0.08]
            at (0.35,-0.64) {\sffamily DW~\@version};
    },
}

% ----------------------
% Miscellaneous Settings
% ----------------------

% Define default document sizing.
\newlength{\sideMargins}
\ifoldmargins
    \setlength{\sideMargins}{1.25in}
\else
    \setlength{\sideMargins}{1in}
\fi
\geometry{
    top=1in,
    bottom=\sideMargins,
    left=\sideMargins,
    right=\sideMargins,
    headsep={0.5\sideMargins - 0.05in},
    footskip={0.5\sideMargins + 0.05in}}

% Define paragraph indent size.
\newlength{\@fixedParIndent}
\setlength{\@fixedParIndent}{20pt}
\setlength\parindent{\@fixedParIndent}

% Define rubber space between first item and preceding paragraph.
\setlength{\topsep}{0pt}

% Avoid overfull lines.
\setlength{\emergencystretch}{\hsize}

% Make a black band to show overfull lines.
\overfullrule=1mm

% Allow the bottom of the page to have white space.
\raggedbottom

% Reduce chances of widows and orphans.
\widowpenalty10000
\clubpenalty10000

% Use French spacing.
\frenchspacing

% Reduce list spacing (enumitem package).
\setlist{
    topsep=0pt,
    parsep=0.5\parskip,
    itemsep=0.5\parskip,
    leftmargin=20pt,
    labelwidth=0pt,
    labelsep=0.5em,
    itemindent=0pt}
\setlist[description]{
    itemindent={0.5em-\parindent}}

% Remove extra spacing around equations (etoolbox package).
\newcommand{\customdisplayskips}{%
    \setlength{\abovedisplayskip}{0.5em}%
    \setlength{\belowdisplayskip}{0.5em}%
    \setlength{\abovedisplayshortskip}{0pt}%
    \setlength{\belowdisplayshortskip}{0pt}%
    \setlength{\jot}{0pt}} % interline spacing (amsmath package)
\appto{\tiny}{\customdisplayskips}
\appto{\scriptsize}{\customdisplayskips}
\appto{\footnotesize}{\customdisplayskips}
\appto{\small}{\customdisplayskips}
\appto{\normalsize}{\customdisplayskips}
\appto{\large}{\customdisplayskips}
\appto{\Large}{\customdisplayskips}
\appto{\LARGE}{\customdisplayskips}
\appto{\huge}{\customdisplayskips}
\appto{\Huge}{\customdisplayskips}

% Change tabular row spacing.
\AtBeginEnvironment{tabular}{\renewcommand{\arraystretch}{1.0}}

% Remove indents from multiline equations.
\setlength\multlinegap{0pt}

% Reduce spacing within arrays (e.g., matrices).
\renewcommand{\arraystretch}{0.62}

% Redefine the quote environment
\renewenvironment{quote}
    {\list{}{\setlength\rightmargin{2\@fixedParIndent}%
        \setlength\leftmargin{2\@fixedParIndent}%
        \rightmargin\leftmargin}%
    \setstretch{1}%
    \setlength{\parskip}{0pt}%
    \setlength{\parindent}{\@fixedParIndent}%
    \item\relax}
    {\endlist\vspace{-0.8em}}

% Create total counters (totalcount package).
\DeclareTotalCounter{figure}
\DeclareTotalCounter{table}

% Remove spacing before and after floats.
\setlength{\floatsep}{1.667\baselineskip}
\setlength{\textfloatsep}{1.667\baselineskip}
\setlength{\intextsep}{1.667\baselineskip}

% Customize captions. The caption package is used instead of manually redefining
% the "@caption" macro because of complications with the hyperref package.
\captionsetup{labelsep=period, %margin={1\parindent,1\parindent},
    skip=1ex, font={stretch=1.0, bf}}

% Define full-page, rotated floats.
\newenvironment{rotfigure}[1][]%
    {\begin{figure}[#1]
        \centering
        \begin{adjustbox}{angle=90}
            \begin{minipage}{\textheight}%
    }{%
            \end{minipage}
        \end{adjustbox}
    \end{figure}}
\newenvironment{rottable}[1][]%
    {\begin{table}[#1]
        \centering
        \begin{adjustbox}{angle=90}
            \begin{minipage}{\textheight}%
    }{%
            \end{minipage}
        \end{adjustbox}
    \end{table}}

% Line numbers (lineno package)
\modulolinenumbers[2]
\setlength\linenumbersep{1cm}
\renewcommand\linenumberfont{
    \mdseries\upshape\normalsize\sffamily\color{gray}}
\ifreview
    \linenumbers
\fi

% Glossary line spacing and left indent (glossaries package)
\renewcommand*{\glsgroupskip}{}
\renewenvironment{theglossary}{%
    \begin{description}[style=standard, labelindent=0pt]}
    {\end{description}}
% Remove the automatic heading from acronyms and glossaries.
\renewcommand{\glossarysection}[2][]{}
% Must come before new entries.
\makeglossaries

% Hyperlink styling (hyperref package)
\hypersetup{
    hypertexnames=true,
    colorlinks=true,
    allcolors=black}

% Remove pdf image warnings.
\pdfsuppresswarningpagegroup=1

% -------------------------------------
% Custom code styles (listings package)
% -------------------------------------

% Pseudocode
\lstdefinestyle{pseudostyle}{
    xleftmargin=30pt, xrightmargin=0pt,
    numbers=left, numberstyle=\scriptsize\ttfamily\color{gray}, numbersep=10pt,
    upquote=true, showstringspaces=false, tabsize=4,
    breaklines=true, breakindent=20pt, breakatwhitespace=true,
    breakautoindent=true,
    aboveskip=0.8em, belowskip=0.2em,
    basicstyle=\linespread{1.1}\ttfamily\small,
    commentstyle=\color{gray}\itshape,
    stringstyle=\color{orange},
    columns=flexible}
\lstdefinelanguage{pseudolang}{
    keywords={function, for, while, do, break, continue,
        if, then, else, end, in, to, until, return},
    keywordstyle=\color{black}\bfseries,
    morecomment=[l]{\%\ },
    morestring=[b]",
    morestring=[b]',
    mathescape=true,
    escapechar=`}
\lstnewenvironment{pseudocode}[1][1]{%
    \lstset{language=pseudolang, style=pseudostyle, firstnumber=#1}}{}
\lstnewenvironment{pseudocodetight}[1][1]{%
    \lstset{language=pseudolang, style=pseudostyle, firstnumber=#1,
        xleftmargin=15pt, numbersep=10pt, rulecolor=\color{white}}}{}

% Python code
\lstdefinestyle{pythonstyle}{
    xleftmargin=40pt, xrightmargin=0pt,
    frame=leftline, framesep=9pt, framerule=2pt, rulecolor=\color{azure!20},
    numbers=left, numberstyle=\scriptsize\ttfamily\color{gray}, numbersep=20pt,
    upquote=true, showstringspaces=false, tabsize=4,
    breaklines=true, breakindent=20pt, breakatwhitespace=true,
    breakautoindent=true,
    aboveskip=0.8em, belowskip=0.2em,
    basicstyle=\ttfamily\footnotesize,
    commentstyle=\color{gray},
    stringstyle=\color{orange},
    keywordstyle=[1]\color{azure},   % keywords
    keywordstyle=[2]\color{azure},   % builtin functions
    keywordstyle=[3]\color{purple},  % NumPy
    keywordstyle=[4]\color{magenta}} % MatplotLib
\lstdefinelanguage{pythonlang}{
    keywords={and, as, assert, break, class, continue, def, del, elif, else,
        except, False, finally, for, from, global, if, import, in, is, lambda,
        None, nonlocal, not, or, pass, raise, return, True, try, while, with,
        yield},
    morekeywords=[2]{abs, aiter, all, any, anext, ascii, bin, bool, breakpoint,
        bytearray, bytes, callable, chr, classmethod, compile, complex, delattr,
        dict, dir, divmod, enumerate, eval, exec, exit, filter, float, format,
        frozenset, getattr, globals, hasattr, hash, help, hex, id, input, int,
        isinstance, issubclass, iter, len, list, locals, map, max, memoryview,
        min, next, object, oct, open, ord, quit, pow, print, property, range,
        repr, reversed, round, set, setattr, slice, sorted, staticmethod, str,
        sum, super, tuple, type, vars, zip},
    morekeywords=[3]{DataSource, LinAlgError, MachAr, NDArrayOperatorsMixin,
        NumpyVersion, abs, absolute, add, all, allclose, amax, amin, angle,
        any, append, apply_along_axis, apply_over_axis, arange, arccos, arccosh,
        arcsin, arcsinh, arctan, arctan2, arctanh, argmax, argmin, argpartition,
        argsort, argwhere, around, array, array2string, array_equal,
        array_equiv, array_repr, array_split, array_str, arraysetops,
        asanyarray, asarray, asarray_chkfinite, ascontiguousarray, asfarray,
        asfortranarray, asmatrix, asscalar, atleast_1d, atleast_2d, atleast_3d,
        average, bartlett, base_repr, binary_repr, bincount, bitwise_and,
        bitwise_or, bitwise_xor, blackman, block, bmat, broadcast,
        broadcast_arrays, broadcast_shapes, broadcast_to, busday_count,
        busday_offset, busdaycalendar, byte_bounds, c_, can_cast, capitalize,
        cbrt, ceil, center, chararray, chebyshev, cholesky, choose, cla, clip,
        column_stack, common_type, compare_chararrays, compress, concatenate,
        cond, conj, conjugate, convolve, copy, copysign, copyto, corrcoef,
        correlate, cos, cosh, count, count_nonzero, cov, cross, cumprod, cumsum,
        datetime_as_string, datetime_data, decode, deg2rad, degrees, delete,
        deprecate, deprecate_with_doc, det, diag, diag_indices,
        diag_indices_from, diagflat, diagonal, diff, digitize, disp, divide,
        divmod, dot, dsplit, dstack, dtype, ediff1d, eig, eigh, eigs, eigvals,
        eigvalsh, einsum, einsum_path, empty, empty_like, encode, endswith,
        equal, errstate, exp, exp2, expand_dims, expandtabs, expm1, extract,
        eye, fabs, fft, fft2, fftfreq, fftn, fftshift, hfft, ifft, ifft2, ifftn,
        ifftshift, ihfft, irfft, irfft2, irfftn, rfft, rfft2, rfftfreq, rfftn,
        fill_diagonal, find, find_common_type, finfo, fix, flat, flatiter,
        flatnonzero, flatten, flip, fliplr, flipud, float_power, floor,
        floor_divide, fmax, fmin, fmod, format_float_positional,
        format_float_scientific, format_parser, frexp, frombuffer, fromfile,
        fromfunction, fromiter, frompyfunc, fromregex, fromstring, fsolve, full,
        full_like, gcd, genfromtxt, geomspace, get_include, get_printoptions,
        getbufsize, geterr, geterrcall, geterrobj, gradient, greater,
        greater_equal, hamming, hanning, heaviside, hermite, hermite_e,
        histogram, histogram2d, histogram_bin_edges, histogramdd, hsplit,
        hstack, hypot, i0, identity, identiy, iinfo, imag, in1d, index, indices,
        inner, insert, interp, intersect1d, inv, invert, is_busday, isalnum,
        isalpha, isclose, iscomplex, iscomplexobj, isdecimal, isdigit, isfinite,
        isfortran, isin, isinf, islower, isnan, isnat, isneginf, isnumeric,
        isposinf, isreal, isrealobj, isscalar, issctype, isspace, issubclass_,
        issubdtype, issubsctype, istitle, isupper, ix_, join, kaiser, kron,
        laguerre, lcm, ldexp, left_shift, legendre, less, less_equal, lexsort,
        linspace, ljust, load, loadtxt, log, log10, log1p, log2, logaddexp,
        logaddexp2, logical_and, logical_not, logical_or, logical_xor, logspace,
        lower, lstrip, lstsq, mask_indices, mat, matmul, matrix_power,
        matrix_rank, max, maximum, maximum_sctype, may_share_memory, mean,
        median, memmap, meshgrid, mgrid, min, min_scalar_type, minimum,
        mintypecode, mod, modf, moveaxis, msort, multi_dot, multiply,
        nan_to_num, nanargmax, nanargmin, nancumprod, nancumsum, nanmax,
        nanmean, nanmedian, nanmin, nanpercentile, nanprod, nanquantile, nanstd,
        nansum, nanvar, ndenumerate, ndindex, nditer, negative, nested_iters,
        nextafter, nonzero, norm, not_equal, obj2sctype, ode, ogrid, ones,
        ones_like, outer, packbits, pad, partition, pcolor, percentile, pi,
        piecewise, pinv, place, polyfit, polynomial, polyval, positive, power,
        printoptions, prod, promote_types, ptp, put, put_along_axis, putmask,
        qr, quad, quantile, r_, rad2deg, radians, rand, randn, ravel,
        ravel_multi_index, real, real_if_close, reciprocal, remainder, repeat,
        replace, repmat, require, reshape, resize, result_type, rfind,
        right_shift, rindex, rint, rjust, roll, rollaxis, rot90, round_, round,
        row_stack, rpartition, rsplit, rstrip, s_, save, savetxt, savez,
        savez_compressed, sctype2char, searchsorted, select, set_printoptions,
        set_string_function, setbufsize, setdiff1d, seterr, seterrcall,
        seterrobj, setxor1d, shape, shares_memory, show_config, sign, signbit,
        sin, sinc, sinh, slogdet, solve, sort, sort_complex, spacing, split,
        splitlines, sqrt, square, squeeze squeeze, stack, startswith, std,
        str_len, strip, subtract, sum, svd, swapaxes, swapcase, take,
        take_along_axis, tan, tanh, tensordot, tensorinv, tensorsolve, tile,
        title, tofile, tolist, trace, translate, transpose, trapz, tri, tril,
        tril_indices, tril_indices_from, trim_zeros, triu, triu_indices,
        triu_indices_from, true_divide, trunc, typename, union1d, unique,
        unpackbits, unravel_index, unwrap, upper, vander, var, vdot, vectorize,
        vsplit, vstack, where, who, xlabel, ylabel, zeros, zeros_like, zfill},
    morekeywords=[4]{acorr, angle_spectrum, annotate, arrow, autoscale, autumn,
        axes, axhline, axhspan, axis, axline, axvline, axvspan, bar, bar_label,
        barbs, barh, bone, box, boxplot, broken_barh, cla, clabel, clf, clim,
        close, cohere, colorbar, connect, contour, contourf, cool, copper, csd,
        delaxes, disconnect, draw, draw_if_interactive, errorbar, eventplot,
        figimage, figlegend, fignum_exists, figtext, figure, fill, fill_between,
        fill_betweenx, findobj, flag, gca, gcf, gci, get,
        get_current_fig_manager, get_figlabels, get_fignums, get_plot_commands,
        getp, ginput, gray, grid, hexbin, hist, hist2d, hlines, hot, hsv,
        imread, imsave, imshow, inferno, install_repl_displayhook, ioff, ion,
        isinteractive, get, legend, locator_params, loglog, magma,
        magnitude_spectrum, margins, matshow, minorticks_off, minorticks_on,
        new_figure_manager, nipy_spectral, pause, pcolor, pcolormesh,
        phase_spectrum, pie, pink, plasma, plot, plot_date, polar, prism, psd,
        quiver, quiverkey, rc, rc_context, rcdefaults, rgrids, savefig, sca,
        scatter, sci, semilogx, semilogy, set_cmap, setp, show, specgram,
        spring, spy, stackplot, stairs, stem, step, streamplot, subplot,
        subplot2grid, subplot_mosaic, subplot_tool, subplots, subplots_adjust,
        summer, suptitle, switch_backend, table, text, thetagrids, tick_params,
        ticklabel_format, tight_layout, title, tricontour, trcontourf,
        tripcolor, triplot, twinx, twiny, uninstall_repl_displayhook,
        violinplot, viridis, vlines, waitforbuttonpress, winter, xcorr, xkcd,
        xlabel, xlim, xscale, xticks, ylabel, ylim, yscale, yticks},
    morecomment=[l]{\#\ },
    morecomment=[s]{"""}{"""},
    morestring=[b]",
    morestring=[b]',
    prebreak={ \char92},
    escapechar=`}
\lstnewenvironment{python}[1][1]{%
    \lstset{language=pythonlang, style=pythonstyle, firstnumber=#1}}{}
\newcommand*{\inputpython}[3]{\lstinputlisting[linerange={{#2}-{#3}},
    firstnumber=#2, language=pythonlang, style=pythonstyle]{#1}}
\newcommand*{\py}{\lstinline[language=pythonlang, basicstyle=\ttfamily]}

% MATLAB code
\lstdefinestyle{matlabstyle}{
    style=Matlab-editor,
    basicstyle=\ttfamily\footnotesize,
    xleftmargin=40pt, xrightmargin=0pt,
    frame=leftline, framesep=9pt, framerule=2pt, rulecolor=\color{green!20},
    numbers=left, numberstyle=\scriptsize\ttfamily\color{gray}, numbersep=20pt,
    upquote=true, showstringspaces=false, tabsize=4,
    breaklines=true, breakindent=20pt, breakatwhitespace=true,
    breakautoindent=true,
    aboveskip=0.8em, belowskip=0.2em,
    prebreak={ ...},
    escapechar=`}
\lstnewenvironment{matlab}[1][1]{%
    \lstset{style=matlabstyle, firstnumber=#1}}{}
\newcommand*{\inputmatlab}[3]{\lstinputlisting[
    style=matlabstyle, linerange={{#2}-{#3}}, firstnumber=#2]{#1}}
\newcommand*{\mat}{\lstinline[style=Matlab-editor, basicstyle=\ttfamily]}

% R code
\lstdefinestyle{rstyle}{
    xleftmargin=40pt, xrightmargin=0pt,
    frame=leftline, framesep=9pt, framerule=2pt, rulecolor=\color{purple!20},
    numbers=left, numberstyle=\scriptsize\ttfamily\color{gray}, numbersep=20pt,
    upquote=true, showstringspaces=false, tabsize=4,
    breaklines=true, breakindent=20pt, breakatwhitespace=true,
    breakautoindent=true,
    aboveskip=0.8em, belowskip=0.2em,
    basicstyle=\linespread{1.2}\ttfamily\footnotesize,
    commentstyle=\color{green},
    stringstyle=\color{red},
    keywordstyle=\color{azure}}
\lstdefinelanguage{rlang}{
    language=R,
    morekeywords={TRUE, FALSE},
    deletekeywords={data, frame, length, as, character, gamma, beta},
    prebreak={},
    escapechar=`}
\lstnewenvironment{rlang}[1][1]{%
    \lstset{language=rlang, style=rstyle, firstnumber=#1}%
    \colorlet{ruleColor}{purple}}{}
\newcommand*{\inputrlang}[3]{\lstinputlisting[linerange={{#2}-{#3}},
    firstnumber=#2, language=rlang, style=rstyle]{#1}}
\newcommand*{\rlng}{\lstinline[language=rlang, basicstyle=\ttfamily]}

% --------------------------
% Define document variables.
% --------------------------

% Define the following values in your document:
%
%   \title{}
%   \author{} % only one person
%   \rank{}
%   \previousdegrees{}
%   \newdegree{}
%   \graduationdate{}
%   \department{\ENG} % \ENY, \ENG, \ENP, \ENC, \ENS, or \ENV
%   \doctype{} % dissertation, thesis, or graduate research paper
%   \docdesignator{}
%   \address{}
%   \disclaimer{}
%   \copyrightstatement{}
%   \committee{{name\\Chair}, {name\\Member}, {name\\Dean, School of EE}}
%   \abstract{}
%   \keywords{}
%   \dedication{}
%   \acknowledgments{}
%
%   \cui{} % Use \DistB, \DistC, \DistD, \DistE, \DistF
%   \classified{}
%   \banner{} % CUI, SECRET, ...
%
% You can define additional authors and their ranks using the following
% commands:
%
%   \authorsecond{}     \ranksecond{}
%   \authorthird{}      \rankthird{}
%   \authorfourth{}     \rankfourth{}

% Define the default title
\title{Set title with $\backslash$title}

% Define the default author
\author{Set author with $\backslash$author}
% Second author
\newif\ifauthorSecond\authorSecondfalse
\def\@authorSecond{}
\newcommand\authorsecond[1]{\authorSecondtrue\def\@authorSecond{#1}}
% Third author
\newif\ifauthorThird\authorThirdfalse
\def\@authorThird{}
\newcommand\authorthird[1]{\authorThirdtrue\def\@authorThird{#1}}
% Fourth author
\newif\ifauthorFourth\authorFourthfalse
\def\@authorFourth{}
\newcommand\authorfourth[1]{\authorFourthtrue\def\@authorFourth{#1}}
% Fifth author
\newif\ifauthorFifth\authorFifthfalse
\def\@authorFifth{}
\newcommand\authorfifth[1]{\authorFifthtrue\def\@authorFifth{#1}}

% Rank of student
\newif\ifrank\rankfalse
\def\@rank{}
\newcommand\rank[1]{\ranktrue\def\@rank{#1}}
% Second rank
\def\@rankSecond{}
\newcommand\ranksecond[1]{\ranktrue\def\@rankSecond{#1}}
% Third rank
\def\@rankThird{}
\newcommand\rankthird[1]{\ranktrue\def\@rankThird{#1}}
% Fourth rank
\def\@rankFourth{}
\newcommand\rankfourth[1]{\ranktrue\def\@rankFourth{#1}}

% Previous degree of student
\def\@previousdegrees{Set previous degrees with $\backslash$previousdegrees}
\newcommand\previousdegrees[1]{\def\@previousdegrees{#1}}

% New, pursued degree of student
\def\@newdegree{Set pursued degree with $\backslash$newdegree}
\newcommand\newdegree[1]{\def\@newdegree{#1}}

% Graduation date
\def\@graduationdate{Set graduation date with $\backslash$graduationdate}
\newcommand\graduationdate[1]{\def\@graduationdate{#1}}

% Department name
\newcommand\ENY{Department of Aeronautics and Astronautics}
\newcommand\ENG{Department of Electrical and Computer Engineering}
\newcommand\ENP{Department of Engineering Physics}
\newcommand\ENC{Department of Mathematics and Statistics}
\newcommand\ENS{Department of Operational Sciences}
\newcommand\ENV{Department of Systems Engineering and Management}
\newif\ifdepartment\departmentfalse
\def\@department{}
\newcommand\department[1]{\departmenttrue\def\@department{#1}}

% Document type
\def\@doctype{thesis}
\newcommand\doctype[1]{\def\@doctype{#1}}

% Document designator
\def\@docdesignator{Set document designator with $\backslash$docdesignator}
\newcommand\docdesignator[1]{\def\@docdesignator{#1}}

% Institute
\def\@institute{Air Force Institute of Technology}
\newcommand\institute[1]{\def\@institute{#1}}

% Address
\def\@address{Wright-Patterson Air Force Base, OH 45433}
\newcommand\address[1]{\def\@address{#1}}

% Disclaimer
\def\@disclaimer{The views expressed in this \@doctype\ are those of the author
    and do not reflect the official policy or position of the United States Air
    Force, the Department of Defense or the United States Government.}
\newcommand\disclaimer[1]{\def\@disclaimer{#1}}

% Copyright
\def\@copyright{This material is declared a work of the United States Government
    and is not subject to copyright protection in the United States.}
\newcommand\copyrightstatement[1]{\def\@copyright{#1}}

% Committee
\def\@committee{{FIXME, Ph.D.\\Chair}, {FIXME, Ph.D.\\Member}}
\newcommand\committee[1]{\def\@committee{#1}}

% Abstract
\def\@abstract{FIXME}
\newcommand\abstract[1]{\def\@abstract{#1}}

% Keywords
\newif\ifkeywords\keywordsfalse
\def\@keywords{}
\newcommand\keywords[1]{\keywordstrue\def\@keywords{#1}}

% Dedication (optional)
\newif\ifdedication
\dedicationfalse
\def\@dedication{}
\newcommand\dedication[1]{\dedicationtrue\def\@dedication{#1}}

% Acknowledgments (optional)
\newif\ifacknowledgments
\acknowledgmentsfalse
\def\@acknowledgments{}
\newcommand\acknowledgments[1]{\acknowledgmentstrue\def\@acknowledgments{#1}}

% Distribution and CUI (see https://www.dodcui.mil/Distribution-Statements/)
\newcommand{\DistA}{Distribution Statement A. Approved for public release:
    distribution is unlimited.}
\newcommand{\DistB}[3]{Distribution Statement B. Distribution authorized to U.S.
    Government agencies; {#1}; {#2}. Other requests for this document must be
    referred to {#3}.}
    % \DistB{category}{date of determination}{controlling DoD office}
\newcommand{\DistC}[3]{Distribution Statement C. Distribution authorized to U.S.
    Government agencies and their contractors; {#1}; {#2}. Other requests for
    this document must be referred to {#3}.}
    % \DistC{category}{date of determination}{controlling DoD office}
\newcommand{\DistD}[3]{Distribution Statement D. Distribution authorized to the
    Department of Defense and U.S. DoD contractors only; {#1}; {#2}. Other
    requests for this document must be referred to {#3}.}
    % \DistD{category}{date of determination}{controlling DoD office}
\newcommand{\DistE}[3]{Distribution Statement E. Distribution authorized to DoD
    Components only; {#1}; {#2}. Other requests for this document must be
    referred to {#3}.}
    % \DistE{category}{date of determination}{controlling DoD office}
\newcommand{\DistF}[2]{Distribution Statement F. Further distribution only as
    directed by {#1} {#2} or higher DoD authority.}
    % \DistF{controlling DoD office}{date of determination}
\newif\ifControlled\Controlledfalse
\def\@cuiBlock{% CUI (see DoDI 5200.48, p. 16)
    Controlled By: AETC \\
    Controlled By: AFIT/{[department]} \\
    CUI Category(ies): {[category]} \\
    Distribution: {[DistB, ..., DistF command]} \\
    POC: {[name]}, {[phone]}}
\newcommand{\cui}[1]{\Controlledtrue\def\@cuiBlock{#1}}
% Classification
\def\@classBlock{}
\newcommand{\classified}[1]{\Controlledtrue\def\@classBlock{#1}}
% Banner
\def\@banner{CUI}
\newcommand{\banner}[1]{\Controlledtrue\def\@banner{#1}}

% Define default header and footer style.
\def\ps@fullheadfoot{%
    \ifControlled
        \def\@oddfoot{\hfil%
            \setstretch{1}%
            \renewcommand{\arraystretch}{1}%
            \begin{tabular}{c}
                \bfseries\MakeUppercase\@banner \\
                \thepage
            \end{tabular}\hfil%
            \renewcommand{\arraystretch}{0.62}}%
        \def\@evenfoot{\hfil%
            \setstretch{1}%
            \renewcommand{\arraystretch}{1}%
            \begin{tabular}{c}
                \bfseries\MakeUppercase\@banner \\
                \thepage
            \end{tabular}\hfil%
            \renewcommand{\arraystretch}{0.62}}%
        \def\@oddhead{\hfil \bfseries\MakeUppercase\@banner\hfil}%
        \def\@evenhead{\hfil \bfseries\MakeUppercase\@banner\hfil}
    \else
        \def\@oddfoot{\hfil\thepage\hfil}%
        \def\@evenfoot{\hfil\thepage\hfil}%
        \def\@oddhead{}%
        \def\@evenhead{}
    \fi}
\def\ps@nopageheadfoot{%
    \ifControlled
        \def\@oddfoot{\hfil \bfseries\MakeUppercase\@banner\hfil}%
        \def\@evenfoot{\hfil \bfseries\MakeUppercase\@banner\hfil}%
        \def\@oddhead{\hfil \bfseries\MakeUppercase\@banner\hfil}%
        \def\@evenhead{\hfil \bfseries\MakeUppercase\@banner\hfil}
    \else
        \def\@oddfoot{}%
        \def\@evenfoot{}%
        \def\@oddhead{}%
        \def\@evenhead{}
    \fi}

% -------------------
% Define title pages.
% -------------------

\newcounter{@prepages}

\newcommand{\makeafittitle}{
    % Cover page
    \clearpage
    \pagestyle{nopageheadfoot}
    \pagenumbering{roman}
    \setcounter{page}{0}
    \begin{center}
        \vspace*{\fill}
        % Display the AFIT crest (2.5 inches wide).
        \tikz{\path (0,0) pic[scale=3.67]{afitcrest};}\\[3em]
        % Display the title, name, and rank of the student.
        \textbf{\MakeUppercase\@title}\\[3em]
        {\textbf{\@date}}\\[3em]
        % In bold type,
        \begin{bfseries}
            % Write the parents of AFIT.
            DEPARTMENT OF THE AIR FORCE\\
            AIR UNIVERSITY\\[1em]
            % Write AFIT in a temporary box so we can use its width.
            \sbox\@tempboxa{\Large\MakeUppercase{\@institute}}%
            \usebox{\@tempboxa}\\[-1.5ex]
            % Make horizontal rules equal to the width of the "AFIT" text.
            \rule{\wd\@tempboxa}{2pt}\\[-2ex]
            \rule{\wd\@tempboxa}{1pt}\\[1ex]
            % Write the address of AFIT.
            \@address\\[1em]
        \end{bfseries}
        % Write the legal statement.
        \MakeUppercase\DistA
        \vspace*{\fill}
    \end{center}
    \clearpage
    % Title page
    \begin{center}
        \vspace*{\fill}
        \textbf{\MakeUppercase\@title}\\[5cm]
        \textbf{\@date}\\[5cm]
        Graduate School of Engineering and Management\\
        \@institute\\
        \@address\\
        \vspace*{\fill}
    \end{center}
    \clearpage
    % Table of contents
    \pagestyle{fullheadfoot}
    \doublespacing % First and only place double spacing is set
    \tableofcontents
    % List of figures
    \iftotalfigures % (totalcount package)
        \listoffigures
    \fi
    % List of tables
    \iftotaltables % (totalcount package)
        \listoftables
    \fi
    % Make note of the number of prefatory pages.
    \setcounter{@prepages}{\the\numexpr\value{page}\relax}
    % Switch to arabic page numbering
    \pagenumbering{arabic}
}

\renewcommand{\maketitle}{
    % Create prefatory pages.
    \clearpage
    \pagestyle{nopageheadfoot}
    \pagenumbering{roman}
    \setcounter{page}{0}
    \coverpage
    \ifinternal
    \else
        \disclaimerpage
        \flyleafpage
    \fi
    \committeepage
    \pagestyle{fullheadfoot}
    \doublespacing % First and only place double spacing is set
    \abstractpage
    \ifinternal
    \else
        \ifdedication % optional
            \dedicationpage
        \fi
        \ifacknowledgments % optional
            \acknowledgmentspage
        \fi
    \fi
    \tableofcontents
    \iftotalfigures % (totalcount package)
        \listoffigures
    \fi
    \iftotaltables % (totalcount package)
        \listoftables
    \fi
    % Make note of the number of prefatory pages.
    \setcounter{@prepages}{\the\numexpr\value{page}\relax}
    % Switch to arabic page numbering
    \pagenumbering{arabic}
}

\newcommand{\coverpage}{%
    \begin{center}
        \vspace*{\fill}
        % Display the AFIT crest (2.5 inches wide).

        \tikz{\path (0,0) pic[scale=3.67]{afitcrest};}\\[3em]
        % Display the title, name, and rank of the student.
        \textbf{\MakeUppercase\@title}\\[1em]
        \MakeUppercase\@doctype\\[1em]
        % Display the author(s) and rank(s).
        \ifauthorFourth
            \begin{tabular}{c@{\hskip 3em}c}
                \@author & \@authorSecond \\
                \@rank & \@rankSecond \\[1em]
                \@authorThird & \@authorFourth \\
                \@rankThird & \@rankFourth
            \end{tabular}\\[1em]
        \else
            \ifauthorThird
                \begin{tabular}{c@{\hskip 3em}c}
                    \@author & \@authorSecond \\
                    \@rank & \@rankSecond
                \end{tabular}\\[1em]
                \@authorThird \\
                \@rankThird \\[1em]
            \else
                \ifauthorSecond
                    \begin{tabular}{c@{\hskip 3em}c}
                        \@author & \@authorSecond \\
                        \@rank & \@rankSecond
                    \end{tabular}\\[1em]
                \else
                    \@author\ifrank, \@rank\fi\\[1em]
                \fi
            \fi
        \fi
        % Display the document designator.
        \@docdesignator\\[3em]
        % In bold type,
        \begin{bfseries}
            % Write the parents of AFIT.
            DEPARTMENT OF THE AIR FORCE\\
            AIR UNIVERSITY\\[1em]
            % Write AFIT in a temporary box so we can use its width.
            \sbox\@tempboxa{\Large\MakeUppercase{\@institute}}%
            \usebox{\@tempboxa}\\[-1.5ex]
            % Make horizontal rules equal to the width of the "AFIT" text.
            \rule{\wd\@tempboxa}{2pt}\\[-2ex]
            \rule{\wd\@tempboxa}{1pt}\\[1ex]
            % Write the address of AFIT.
            \@address\\[1em]
        \end{bfseries}
        % Write the legal statement.
        \ifinternal
            \vspace*{\fill}
        \else
            \ifControlled
                \vspace*{\fill}\hspace{1em}
                \begin{minipage}[t]{6.5cm}
                    \footnotesize\raggedright
                    \setlength{\parindent}{-1em}
                    \@classBlock
                \end{minipage}
                \hfill
                \begin{minipage}[t]{6.5cm}
                    \footnotesize\raggedright
                    \setlength{\parindent}{-1em}
                    \@cuiBlock
                \end{minipage}
            \else
                \MakeUppercase\DistA
                \vspace*{\fill}
            \fi
        \fi
    \end{center}
    \clearpage
}

\newcommand{\disclaimerpage}{%
    \noindent\@docdesignator\par
    \vspace{1.25em}
    \noindent \@disclaimer \\[1em]
    \noindent \@copyright
    \clearpage
}

\newcommand{\flyleafpage}{%
    \noindent\@docdesignator\par
    \vspace{1.25em}
    \begin{center}
        \MakeUppercase\@title\\[3em]
        \MakeUppercase\@doctype\\[3em]
        Presented to the Faculty\\[3em]
        \ifdepartment
            \@department\\
        \fi
        Graduate School of Engineering and Management\\
        \@institute\\
        Air University\\
        Air Education and Training Command\\[3em]
        in Partial Fulfillment of the Requirements for the\\
        Degree of \@newdegree\\[3em]
        % Display the author(s), previous degree(s), and rank(s).
        \ifauthorFourth
            \begin{tabular}{c@{\hskip 3em}c}
                \@author, \@previousdegrees & \@authorSecond \\
                \@rank & \@rankSecond \\[1.25em]
                \@authorThird & \@authorFourth \\
                \@rankThird & \@rankFourth
            \end{tabular}\\[3em]
        \else
            \ifauthorThird
                \begin{tabular}{c@{\hskip 3em}c}
                    \@author, \@previousdegrees & \@authorSecond \\
                    \@rank & \@rankSecond
                \end{tabular}\\[1.25em]
                \@authorThird \\
                \@rankThird \\[3em]
            \else
                \ifauthorSecond
                    \begin{tabular}{c@{\hskip 3em}c}
                        \@author, \@previousdegrees & \@authorSecond \\
                        \@rank & \@rankSecond
                    \end{tabular}\\[3em]
                \else
                    \ifrank
                        \@author, \@previousdegrees \\
                        \@rank \\[3em]
                    \else
                        \@author, \@previousdegrees \\[3em]
                    \fi
                \fi
            \fi
        \fi
        \@graduationdate\\[3em]
        \ifControlled
            % Do not show anything here if not Distribution A.
        \else
            \MakeUppercase\DistA
        \fi
    \end{center}
    \clearpage
}

\newcommand{\committeepage}{%
    \noindent\@docdesignator\par
    \vspace{1.25em}
    \begin{center}
        \MakeUppercase\@title\\[6em]
        % Display the author(s), previous degree(s), and rank(s).
        \ifauthorFourth
            \begin{tabular}{c@{\hskip 3em}c}
                \@author, \@previousdegrees & \@authorSecond \\
                \@rank & \@rankSecond \\[1.25em]
                \@authorThird & \@authorFourth \\
                \@rankThird & \@rankFourth
            \end{tabular}\\[6em]
        \else
            \ifauthorThird
                \begin{tabular}{c@{\hskip 3em}c}
                    \@author, \@previousdegrees & \@authorSecond \\
                    \@rank & \@rankSecond
                \end{tabular}\\[1.25em]
                \@authorThird \\
                \@rankThird \\[6em]
            \else
                \ifauthorSecond
                    \begin{tabular}{c@{\hskip 3em}c}
                        \@author, \@previousdegrees & \@authorSecond \\
                        \@rank & \@rankSecond
                    \end{tabular}\\[6em]
                \else
                    \ifrank
                        \@author, \@previousdegrees \\
                        \@rank \\[6em]
                    \else
                        \@author, \@previousdegrees \\[6em]
                    \fi
                \fi
            \fi
        \fi
        % List the committee members.
        Committee Membership:
        \@for\@member:=\@committee\do{\\[6em]\@member}
    \end{center}
    \clearpage
}

\newcommand{\abstractpage}{
    \noindent\@docdesignator\par
    \phantomsection
    \addcontentsline{toc}{chapter}{Abstract}
    \centerline{\bfseries Abstract}\par
    \vspace*{0.5\baselineskip} % 3/2 - 2/2 = 1/2
    \@abstract\par
    \ifkeywords
        \textbf{Keywords:} \@keywords
    \fi
    \clearpage
}

\newcommand{\dedicationpage}{
    \noindent\@docdesignator\par
    \vspace*{\fill}
    \phantomsection
    \addcontentsline{toc}{chapter}{Dedication}
    \begin{center}
        \itshape \@dedication
    \end{center}
    \vspace*{\fill}
    \clearpage
}

\newcommand{\acknowledgmentspage}{
    \noindent\@docdesignator\par
    \phantomsection
    \addcontentsline{toc}{chapter}{Acknowledgments}
    \centerline{\bfseries Acknowledgments}\par
    \vspace*{0.5\baselineskip} % 3/2 - 2/2 = 1/2
    \@acknowledgments\par\vspace*{3em}
    \par\noindent\hspace*{3.25in}%
    \parbox[t]{3in}{\raggedright\@author}
    \clearpage
}

% The optional parameter is the author's name.
\newenvironment{vita}[1][]{
    \clearpage
    % Create a section.
    \phantomsection
    % Add to the table of contents and make the heading.
    \if\relax\detokenize{#1}\relax
        \addcontentsline{toc}{chapter}{Vita}
        \noindent\begin{center}\textbf{Vita}\end{center}\par
        % 3 lines below chapter title
        \vspace*{0.5\baselineskip} % 3/2 - 2/2 = 1/2
    \else
        \addcontentsline{toc}{chapter}{Vita:~#1}
        \noindent\begin{center}\textbf{Vita:~#1}\end{center}\par
        % 3 lines below chapter title
        \vspace*{0.5\baselineskip} % 3/2 - 2/2 = 1/2
    \fi
}{
    \clearpage
}

% -----------------------
% Define heading numbers.
% -----------------------

\renewcommand\thechapter{\Roman{chapter}}
\renewcommand\thesection{\arabic{chapter}.\arabic{section}}
\renewcommand\thesubsection{\thesection.\arabic{subsection}}
\renewcommand\thesubsubsection{\thesubsection.\arabic{subsubsection}}
\renewcommand\theparagraph{}
\renewcommand\thesubparagraph{}
\renewcommand\theequation{\arabic{equation}}
\renewcommand\thefigure{\arabic{figure}}
\renewcommand\thetable{\arabic{table}}

% Set equation, figure, and table to straight-through-the-text,
% versus by-chapter numbering here. '\@removefromreset' is built-in.
\@removefromreset{equation}{chapter}
\@removefromreset{figure}{chapter}
\@removefromreset{table}{chapter}

% -----------------------------------
% Define '\chapter', '\section', etc.
% -----------------------------------

% The redefinition of 'chapter' serves to make sure the document title appears
% automatically before the first chapter and so 'Appendix' comes before appendix
% chapter. This code is based on the "Standard Document Classes for LaTeX."

% Redefine the "appendix" command to set a flag. This flag will be used to
% determine when a "chapter" is really an appendix. This is needed since
% "\ifx\@chapapp\appendixname" does not seem to work.
\newif\ifinappendix\inappendixfalse
\let\appendixold\appendix
\def\appendix{\inappendixtrue%
    \renewcommand\thesection{\Alph{chapter}.\arabic{section}}%
    \appendixold}

% Define the table of contents level for appendices so that the hyperref package
% does not complain.
\@namedef{toclevel@appendix}{0}

% Redefine the "chapter" command. This command sets up the placement of the
% chapter title and calls "@chapter" if it is numbered and "@schapter" (star
% chapter) if it is not numbered.
\renewcommand{\chapter}{%
    % If chapters should start on a right-side page (odd numbered) then do so.
    % The command 'cleardoublepage' does not necessarily add two pages.
    \if@openright
        \cleardoublepage
    \else
        \clearpage
    \fi
    % Prevent floats from going to top of page.
    \global\@topnum\z@
    % Do indent the first paragraph after the heading.
    \@afterindenttrue
    % For the unstarred chapter, use '\@chapter'. Else, use '\@schapter'.
    \secdef\@chapter\@schapter
}

% Redefine the "@chapter" command.
\renewcommand{\@chapter}[2][]{
    % If the chapter is in the main matter of the document,
    \if@mainmatter
        % Increment the chapter counter.
        \refstepcounter{chapter}
        % Print the chapter heading to the terminal.
        \typeout{\@chapapp\space\thechapter.}
        % If the chapter or appendix label is "Appendix"
        \ifinappendix
            % Add the appendix to the ToC. "numberline" makes the number
            % flush left. "thechapter" is the number.
            \addcontentsline{toc}{appendix}{%
                \protect\numberline{\appendixname\ \thechapter.}#1%
            }
        \else
            % Add the chapter to the ToC. "numberline" makes the number
            % flush left. "thechapter" is the number.
            \addcontentsline{toc}{chapter}{%
                \protect\numberline{\thechapter.}#1%
            }
        \fi
    % If the chapter is not in the main matter of the document,
    \else
        % Just add the chapter name to the ToC.
        \addcontentsline{toc}{chapter}{#1}
    \fi
    % Define the chapter for the page header.
    \chaptermark{#1}
    % Print the chapter on the page.
    \if@twocolumn
        % Use the full text width for the chapter title.
        \@topnewpage[\@makechapterhead{#2}]
    \else
        \@makechapterhead{#2}
        % Suppress indentation
        \@afterheading
    \fi
}

% Define the guide lines for chapters.
\def\@firstchapterguides{%
    \tikz[remember picture, overlay]{
        % Header and footer centers.
        \draw[red, very thin, dashed] (current page.north west)
            ++(9.525,-1.27) -- ++(2.54,0);
        \draw[red, very thin, dashed] (current page.south west)
            ++(9.525,{0.5\sideMargins}) -- ++(2.54,0);
        % Margins
        \draw[red, very thin] (current page.north west)
            ++(\sideMargins,-2.54) coordinate(tl) rectangle
            ++(\textwidth,-\textheight);
        % Left-sided tick marks
        \foreach \n in {1, 2, 5, 6, 7, 9, 10}{
            \draw[red, very thin] (tl)
                ++(0,{-0.5*\n*\baselineskip})
                -- ++(0.2,0);
        }
        % Paper title position
        \draw[red, very thin] (tl) ++(0,{-1.5*\baselineskip})
            -- ++(\textwidth,0);
        \draw[red, very thin] (tl) ++(0,{-2*\baselineskip})
            -- ++(\textwidth,0);
        % Chapter I title position
        \draw[red, very thin] (tl) ++(0,{-4*\baselineskip})
            -- ++(\textwidth,0);
        % First line of body position
        \draw[red, very thin] (tl) ++(0,{-5.5*\baselineskip})
            -- ++(\textwidth,0);}}
\def\@nextchapterguides{%
    \tikz[remember picture, overlay]{
        % Header and footer centers.
        \draw[red, very thin, dashed] (current page.north west)
            ++(9.525,-1.27) -- ++(2.54,0);
        \draw[red, very thin, dashed] (current page.south west)
            ++(9.525,{0.5\sideMargins}) -- ++(2.54,0);
        % Margins
        \draw[red, very thin] (current page.north west)
            ++(\sideMargins,-2.54) coordinate(tl) rectangle
            ++(\textwidth,-\textheight);
        % Left-sided tick marks
        \foreach \n in {2, 3}{
            \draw[red, very thin] (tl)
                ++(0,{-0.5*\n*\baselineskip})
                -- ++(0.2,0);
        }
        % Chapter title position
        \draw[red, very thin] (tl) ++(0,{-0.5*\baselineskip})
            -- ++(\textwidth,0);
        % First line of body position
        \draw[red, very thin] (tl) ++(0,{-2*\baselineskip})
            -- ++(\textwidth,0);}
}

% Redefine numbered chapter title.
\renewcommand{\@makechapterhead}[1]{%
    \noindent\begin{center}
        % If the type is Appendix,
        \ifinappendix
            % Write "Appendix", the number, and the title.
            \textbf{\appendixname\ \thechapter.\ \ #1}
            % 3 lines below chapter title
            \vspace*{0.5\baselineskip} % 3/2 - 2/2 = 1/2
        % Or, if the type is Chapter,
        \else
            % If this is the first chapter,
            \ifnum\value{chapter}=1
                % 3 lines before paper title
                \vspace*{0.5\baselineskip} % 3/2 - 2/2 = 1/2
                % Restate the title in uppercase.
                \MakeUppercase\@title\par
                % 4 lines after paper title
                \vspace*{\baselineskip} % 4/2 - 2/2 = 2/2
                % Show guides
                \ifshowguides
                    \@firstchapterguides
                \fi
            \else
                % Show guides
                \ifshowguides
                    \@nextchapterguides
                \fi
            \fi
            % Write the chapter number and title.
            \textbf{\thechapter.\ \ #1}
            % 3 lines below chapter title
            \vspace*{0.5\baselineskip} % 3/2 - 2/2 = 1/2
        \fi
    \end{center}
}

\renewcommand{\@schapter}[2][]{
    % Define the chapter for the page header.
    \chaptermark{#1}
    % Print the chapter on the page.
    \if@twocolumn
        % Use the full text width for the chapter title.
        \@topnewpage[\@makeschapterhead{#2}]
    \else
        \@makeschapterhead{#2}
        % Suppress indentation
        \@afterheading
    \fi
}

% Unnumbered chapter title
\renewcommand{\@makeschapterhead}[1]{%
    \noindent\begin{center}
        \textbf{#1}
    \end{center}
}

% Add spacing after Bibliography title and add the title to the TOC.
\AtBeginBibliography{\vspace*{0.5\baselineskip}}
\let\printbibliographyold\printbibliography
\renewcommand{\printbibliography}[1][]{%
  \clearpage
  \phantomsection
  \addcontentsline{toc}{appendix}{\bibname}
  \printbibliographyold[#1] % Pass optional arguments
}

% Redefine section levels using the "@startsection" command (built-in). Define
% the formatting: name, level, indent, beforeskip, afterskip, and style.
% The before and after skips must be positive (1sp) to push the body text
% to the next line. The "addvspace" is necessary to force LaTeX to add the
% requested vertical space even for sections at the start of a chapter.
\renewcommand{\section}{%
    \@startsection{section}{1}{\z@}{1sp\addvspace{\f@size pt}}{1sp}
    {\normalfont\normalsize\bfseries}}
\renewcommand{\subsection}{%
    \@startsection{subsection}{2}{\parindent}{\f@size pt}{1sp}
    {\normalfont\normalsize\bfseries\itshape}}
\renewcommand{\subsubsection}{%
    \@startsection{subsubsection}{3}{2\parindent}{\f@size pt}{1sp}
    {\normalfont\normalsize\itshape}}
\renewcommand{\paragraph}{%
    \@startsection{paragraph}{4}{\parindent}{1sp}{-1em}
    {\normalfont\normalsize\bfseries}}
\renewcommand{\subparagraph}{%
    \@startsection{subparagraph}{5}{2\parindent}{1sp}{-1em}
    {\normalfont\normalsize\bfseries\itshape}}

% Set depth of section numbering here; use a number from -1 to 3
\setcounter{tocdepth}{3}
\setcounter{secnumdepth}{3}

% --------------------------------
% Define ToC, LoF, and LoT Styles.
% --------------------------------

% In order to get the headers of the lists left justified and to ensure double
% spacing between list entries and single spacing within a single entry, the
% lists are redefined here.

% --
% Table of Contents
% --

% Change the table of contents header.
\renewcommand\contentsname{Table of Contents}
% Set the width of the box for the page number to infinite horizontal stretch or
% shrink. This will keep it from running into the right page margin.
\renewcommand\@pnumwidth{0pt {\hss}}
% Set the separation between dots to 1 mu.
\renewcommand{\@dotsep}{1}
% Set the right margin for multi-line entries to 6em, with infinite stretch.
\renewcommand{\@tocrmarg}{6em plus 1fil}

% Define the contents lines. The "pagebreak" command encourages page breaks
% after chapter and appendix entries. The "[3]" (out of 0 to 4) means more
% likely. The "@dottedtocline" defines the format of the line and takes three
% parameters: level of the entry, left indentation, and width for the heading
% number.
\def\l@appendix{\pagebreak[3] \@dottedtocline{0}{0pt}{6.5em}}
\def\l@chapter{\pagebreak[3] \@dottedtocline{0}{0pt}{2.5em}}
\def\l@section{\@dottedtocline{1}{2.5em}{2.5em}}
\def\l@subsection{\@dottedtocline{2}{5.0em}{3.0em}}
\def\l@subsubsection{\@dottedtocline{3}{7.5em}{3.5em}}
\def\l@paragraph{\@dottedtocline{4}{10em}{2.5em}}
\def\l@subparagraph{\@dottedtocline{5}{12.5em}{2.5em}}

% Redefine the list.
\renewcommand\tableofcontents{%
    % Print the list title.
    \noindent\textbf{\contentsname}\par
    % Print the list.
    \@starttoc{toc}%
    % Start a new page.
    \clearpage
}

% --
% List of Figures
% --

% Redefine the list.
\renewcommand\listoffigures{%
    % Add the list to the table of contents.
    \phantomsection
    \addcontentsline{toc}{chapter}{\listfigurename}
    % Print the list title.
    \noindent\textbf{\listfigurename}\par
    % Print the list.
    \@starttoc{lof}%
    % Start a new page.
    \clearpage
}

% Define the contents line. The "pagebreak" command encourages page breaks after
% an entry. The "[3]" (out of 0 to 4) means more likely. The "@dottedtocline"
% defines the format of the line and takes three parameters: level of the entry,
% left indentation, and width for the heading number.
\def\l@figure{\pagebreak[3] \@dottedtocline{1}{0pt}{2em}}

% --
% List of Tables
% --

% Redefine the list.
\renewcommand\listoftables{%
    % Add the list to the table of contents.
    \phantomsection
    \addcontentsline{toc}{chapter}{\listtablename}
    % Print the list title.
    \noindent\textbf{\listtablename}\par
    % Print the list.
    \@starttoc{lot}%
    % Start a new page.
    \clearpage
}

% Define the contents line. The "pagebreak" command encourages page breaks after
% an entry. The "[3]" (out of 0 to 4) means more likely. The "@dottedtocline"
% defines the format of the line and takes three parameters: level of the entry,
% left indentation, and width for the heading number.
\def\l@table{\pagebreak[3] \@dottedtocline{1}{0pt}{2em}}

% -----------------
% Standard Form 298
% -----------------

% This version of SF 298 was closely modeled by David Woodburn after the 2020
% version of the form found at
%
%   https://www.gsa.gov/forms-library/report-documentation-page.
%
% Note, the instructions for this form can also be found there. The following
% variables need to be defined in order to complete the Report Documentation
% Page (SF 298):
%
%   \sfStartDate{}
%   \sfEndDate{}
%   \sfContractNumber{}
%   \sfGrantNumber{}
%   \sfProgramElementNumber{}
%   \sfProjectNumber{}
%   \sfTaskNumber{}
%   \sfWorkUnitNumber{}
%   \sfSponsorAgency{}
%   \sfSponsorAcronyms{}
%   \sfSponsorReportNumber{}
%   \sfDistribution{}
%   \sfSupplementaryNotes{}
%   \sfReportClassification{}
%   \sfAbstractClassification{}
%   \sfPageClassification{}
%   \sfAbstractLimitation{}
%   \sfResponsiblePerson{}
%   \sfPhoneNumber{}
%
% The rest of the needed information is automatically retrieved from the
% document variables: "\title", "\author", etc. However, you can override those
% definitions with the following commands:
%
%   \sfReportDate{}
%   \sfReportType{}
%   \sfTitle{}
%   \sfAuthors{}
%   \sfDepartment{}
%   \sfAddress{}
%   \sfDocDesignator{}
%   \sfAbstract{}
%   \sfSubjectTerms{}
%   \sfPageCount{}
%   \sfClassification{}

% Variables
\def\@sfStartDate{xxx}
\newcommand{\sfStartDate}[1]{\def\@sfStartDate{#1}}
\def\@sfEndDate{xxx}
\newcommand{\sfEndDate}[1]{\def\@sfEndDate{#1}}
\def\@sfContractNumber{xxx}
\newcommand{\sfContractNumber}[1]{\def\@sfContractNumber{#1}}
\def\@sfGrantNumber{xxx}
\newcommand{\sfGrantNumber}[1]{\def\@sfGrantNumber{#1}}
\def\@sfProgramElementNumber{xxx}
\newcommand{\sfProgramElementNumber}[1]{\def\@sfProgramElementNumber{#1}}
\def\@sfProjectNumber{xxx}
\newcommand{\sfProjectNumber}[1]{\def\@sfProjectNumber{#1}}
\def\@sfTaskNumber{xxx}
\newcommand{\sfTaskNumber}[1]{\def\@sfTaskNumber{#1}}
\def\@sfWorkUnitNumber{xxx}
\newcommand{\sfWorkUnitNumber}[1]{\def\@sfWorkUnitNumber{#1}}
\def\@sfSponsorAgency{xxx}
\newcommand{\sfSponsorAgency}[1]{\def\@sfSponsorAgency{#1}}
\def\@sfSponsorAcronyms{xxx}
\newcommand{\sfSponsorAcronyms}[1]{\def\@sfSponsorAcronyms{#1}}
\def\@sfSponsorReportNumber{xxx}
\newcommand{\sfSponsorReportNumber}[1]{\def\@sfSponsorReportNumber{#1}}
\def\@sfDistribution{xxx}
\newcommand{\sfDistribution}[1]{\def\@sfDistribution{#1}}
\def\@sfSupplementaryNotes{xxx}
\newcommand{\sfSupplementaryNotes}[1]{\def\@sfSupplementaryNotes{#1}}
\def\@sfReportClassification{xxx}
\newcommand{\sfReportClassification}[1]{\def\@sfReportClassification{#1}}
\def\@sfAbstractClassification{xxx}
\newcommand{\sfAbstractClassification}[1]{\def\@sfAbstractClassification{#1}}
\def\@sfPageClassification{xxx}
\newcommand{\sfPageClassification}[1]{\def\@sfPageClassification{#1}}
\def\@sfAbstractLimitation{xxx}
\newcommand{\sfAbstractLimitation}[1]{\def\@sfAbstractLimitation{#1}}
\def\@sfResponsiblePerson{xxx}
\newcommand{\sfResponsiblePerson}[1]{\def\@sfResponsiblePerson{#1}}
\def\@sfPhoneNumber{xxx}
\newcommand{\sfPhoneNumber}[1]{\def\@sfPhoneNumber{#1}}
\def\@sfClassification{}
\newcommand{\sfClassification}[1]{\def\@sfClassification{#1}}
% Default variables
\def\@sfReportDate{\today}
\newcommand{\sfReportDate}[1]{\def\@sfReportDate{#1}}
\def\@sfReportType{\MakeUppercase{\@doctype}}
\newcommand{\sfReportType}[1]{\def\@sfReportType{#1}}
\def\@sfTitle{\@title}
\newcommand{\sfTitle}[1]{\def\@sfTitle{#1}}
\def\@sfAuthors{\@author\ifrank, \@rank\fi}
\newcommand{\sfAuthors}[1]{\def\@sfAuthors{#1}}
\def\@sfDepartment{\@department}
\newcommand{\sfDepartment}[1]{\def\@sfDepartment{#1}}
\def\@sfAddress{\@institute\\\@address}
\newcommand{\sfAddress}[1]{\def\@sfAddress{#1}}
\def\@sfDocDesignator{\@docdesignator}
\newcommand{\sfDocDesignator}[1]{\def\@sfDocDesignator{#1}}
\def\@sfSubjectTerms{\@keywords}
\def\@sfShortAbstract{\@abstract}
\newcommand{\sfAbstract}[1]{\def\@sfShortAbstract{#1}}
\newcommand{\sfSubjectTerms}[1]{\def\@sfSubjectTerms{#1}}
\def\@sfPageCount{\the\numexpr\value{page}+\the@prepages\relax}
\newcommand{\sfPageCount}[1]{\def\@sfPageCount{#1}}

\newcommand{\sfTwoNineEight}{
    % Ensure the form starts on a new page
    % without margins or page numbers.
    \clearpage\thispagestyle{empty}%
    \newgeometry{margin=0pt}%
    % Set the picture dimension units to points.
    \setlength{\unitlength}{1pt}%
    % Get the vertical shift for the picture origin.
    \newcount\ptPageHeight\ptPageHeight=795% 11 inches to points
    \advance\ptPageHeight by -10% font pt height
    % Draw page 1 of the form.
    \noindent\begin{picture}(0,0)(0,\ptPageHeight)
        % Set the font.
        \fontfamily{phv}\selectfont\setstretch{1}%
        % Surrounding box
        \linethickness{2pt}%
        \put(20,37){\framebox(574,731){}}
        % Horizontal lines
        \linethickness{0.5pt}%
        \put(20,733){\line(1,0){574}} % above 1.
        \put(380,718){\line(1,0){214}} % below 3.
        \put(20,690){\line(1,0){574}}
        \put(20,654){\line(1,0){574}}
        \put(20,617){\line(1,0){574}}
        \put(20,581){\line(1,0){574}}
        \put(20,538){\line(1,0){574}}
        \put(20,466){\line(1,0){574}}
        \put(20,412){\line(1,0){574}}
        \put(20,338){\line(1,0){574}}
        \put(20,264){\line(1,0){574}}
        \put(20,191){\line(1,0){574}}
        \put(20,117){\line(1,0){574}}
        \put(20,102){\line(1,0){323}}
        \put(20,74){\line(1,0){574}}
        % Vertical lines
        \put(487,690){\line(0,1){28}} % after 3. START DATE
        \put(380,690){\line(0,1){43}} % after 2.
        \put(127,690){\line(0,1){43}} % after 1.
        \put(403,581){\line(0,1){73}} % after 5b. and 5e.
        \put(211,581){\line(0,1){73}} % after 5a. and 5d.
        \put(451,466){\line(0,1){72}} % after 7.
        \put(487,412){\line(0,1){54}} % after 10.
        \put(380,412){\line(0,1){54}} % after 9.
        \put(487,74){\line(0,1){43}} % after 17.
        \put(343,74){\line(0,1){43}} % after 16.
        \put(235,74){\line(0,1){28}} % after 16b.
        \put(127,74){\line(0,1){28}} % after 16a.
        \put(415,37){\line(0,1){37}} % after 19a.
        % SF 298 classification
        \fontsize{11pt}{12pt}\selectfont%
        \put(20,775){\makebox(574,14){\bfseries\@sfClassification}}
        \put(20,05){\makebox(574,14){\bfseries\@sfClassification}}
        % Text labels
        \bfseries%
        \fontsize{12pt}{13pt}\selectfont%
        \put(206,745){\makebox(55,14){REPORT}}
        \put(247,745){\makebox(107,14){DOCUMENTA}}
        \put(301,745){\makebox(107,14){TION}}
        \put(371,745){\makebox(35,14){PAGE}}
        \fontsize{8pt}{9pt}\selectfont%
        \put(20,719){\makebox(107,10)[tl]{\ 1.\ REPORT DATE}}
        \put(127,719){\makebox(253,10)[tl]{\,\ 2.\ REPORT TYPE}}
        \put(380,719){\makebox(214,10)[tl]{\ \ 3.\ DATES\, COVERED}}
        \put(380,705){\makebox(107,10)[tl]{\ START\, DATE}}
        \put(487,705){\makebox(107,10)[tl]{\,\ END DATE}}
        \put(20,676){\makebox(574,10)[tl]{\,4.\ TITLE AND SUBTITLE}}
        \put(20,640){\makebox(191,10)[tl]{\,5a.\ CONTRACT\, NUMBER}}
        \put(211,640){\makebox(192,10)[tl]{\,\ 5b.\ GRANT NUMBER}}
        \put(403,640){\makebox(191,10)[tl]{\,\ 5c.\ PROGRAM ELEMENT NUMBER}}
        \put(20,604){\makebox(191,10)[tl]{\,5d.\ PROJECT NUMBER}}
        \put(211,604){\makebox(192,10)[tl]{\,\ 5e.\ TASK NUMBER}}
        \put(403,604){\makebox(191,10)[tl]{\,\ 5f.\ WORK UNIT NUMBER}}
        \put(20,568){\makebox(574,10)[tl]{\ 6.\ AUTHOR(S)}}
        \put(20,525){\makebox(431,10)[tl]
            {\ 7.\ PERFORMING ORGANIZATION NAME(S) AND ADDRESS(ES)}}
        \put(451,525){\makebox(143,10)[tl]{\,\ 8.\ PERFORMING ORGANIZATION}}
        \put(451,515){\makebox(143,10)[tl]{\,\ REPORT NUMBER}}
        \put(20,452){\makebox(360,10)[tl]
            {\ 9.\ SPONSORING/MONITORING AGENCY NAME(S) AND ADDRESS(ES)}}
        \put(380,452){\makebox(107,10)[tl]{\ 10.\ SPONSOR/MONITOR'S}}
        \put(380,443){\makebox(107,10)[tl]{\ ACRONYM(S)}}
        \put(487,452){\makebox(107,10)[tl]{\,\ 11.\ SPONSOR/MONITOR'S}}
        \put(487,443){\makebox(107,10)[tl]{\,\ REPORT NUMBER(S)}}
        \put(20,398){\makebox(574,10)[tl]
            {\ 12.\ DISTRIBUTION/AVAILABILITY\, STATEMENT}}
        \put(20,325){\makebox(574,10)[tl]{\ 13.\ SUPPLEMENTARY NOTES}}
        \put(20,251){\makebox(574,10)[tl]{\ 14.\ ABSTRACT}}
        \put(20,177){\makebox(574,10)[tl]{\ 15.\ SUBJECT TERMS}}
        \put(20,104){\makebox(323,10)[tl]
            {\,\ 16.\ SECURITY CLASSIFICATION OF:}}
        \put(20,89){\makebox(107,10)[tl]{\ a.\ REPORT}}
        \put(127,89){\makebox(108,10)[tl]{\,\ b.\ ABSTRACT}}
        \put(235,89){\makebox(108,10)[tl]{\,\ c.\ THIS PAGE}}
        \put(343,104){\makebox(144,10)[tl]{\,\ 17.\ LIMITATION OF ABSTRACT}}
        \put(487,104){\makebox(107,10)[tl]{\,\ 18.\ NUMBER OF PAGES}}
        \put(20,60){\makebox(395,10)[tl]
            {\ 19a.\ NAME OF RESPONSIBLE PERSON}}
        \put(415,60){\makebox(179,10)[tl]{\,\ 19b.\ PHONE NUMBER
            {\mdseries\itshape(Include area code)}}}
        % Footer
        \put(20,23){\makebox(40,10)[tl]{\mdseries\,Page 1 of 2}}
        \put(20,18){\makebox(574,10){\mdseries PREVIOUS EDITION IS OBSOLETE.}}
        \put(419,20){\makebox(179,10)[tr]{%
            \fontsize{10pt}{11pt}\selectfont%
            STANDARD FORM 298 (REV.\,\ 5/2020)}}
        \put(419,9){\makebox(179,10)[tr]
            {\mdseries\itshape Prescribed by ANSI Std. Z39.18}}
        % Text entries
        \rmfamily\mdseries%
        \fontsize{9pt}{11pt}\selectfont%
        \put(20,698){\makebox(107,14){\@sfReportDate}}
        \put(127,698){\makebox(253,14){\@sfReportType}}
        \put(380,692){\makebox(107,14){\@sfStartDate}}
        \put(487,692){\makebox(107,14){\@sfEndDate}}
        \put(24,656){\parbox[b][20pt][c]{566pt}{\@sfTitle}}
        \put(22,621){\makebox(185,20){\@sfContractNumber}}
        \put(214,621){\makebox(185,20){\@sfGrantNumber}}
        \put(407,621){\makebox(185,20){\@sfProgramElementNumber}}
        \put(22,585){\makebox(185,20){\@sfProjectNumber}}
        \put(214,585){\makebox(185,20){\@sfTaskNumber}}
        \put(407,585){\makebox(185,20){\@sfWorkUnitNumber}}
        \put(24,541){\parbox[b][28pt][c]{566pt}{\@sfAuthors}}
        \put(24,469){\parbox[b][57pt][c]{421pt}
            {\@sfDepartment\par\@sfAddress}}
        \put(454,469){\makebox(138,47){\@sfDocDesignator}}
        \put(24,415){\parbox[b][39pt][c]{350pt}{\@sfSponsorAgency}}
        \put(382,415){\makebox(102,30){\@sfSponsorAcronyms}}
        \put(490,415){\makebox(102,30){\@sfSponsorReportNumber}}
        \put(24,342){\parbox[b][58pt][c]{566pt}{\@sfDistribution}}
        \put(24,268){\parbox[b][58pt][c]{566pt}{\@sfSupplementaryNotes}}
        \put(24,194){\parbox[b][58pt][c]{566pt}{\@sfShortAbstract}}
        \put(24,121){\parbox[b][58pt][c]{566pt}{\@sfSubjectTerms}}
        \put(22,77){\makebox(101,14){\@sfReportClassification}}
        \put(130,77){\makebox(101,14){\@sfAbstractClassification}}
        \put(238,77){\makebox(101,14){\@sfPageClassification}}
        \put(346,77){\makebox(138,28){\@sfAbstractLimitation}}
        \put(490,77){\makebox(102,28){\@sfPageCount}}
        \put(22,41){\makebox(390,21){\@sfResponsiblePerson}}
        \put(418,41){\parbox[b][21pt][c]{174pt}{\centering\@sfPhoneNumber}}
    \end{picture}\clearpage
    % Draw page 2 of the form.
    \noindent\begin{picture}(0,0)(0,\ptPageHeight)
        % Set the font.
        \fontfamily{phv}\selectfont\setstretch{1}%
        % Surrounding box
        \linethickness{2pt}%
        \put(20,37){\framebox(574,731){}}
        % Horizontal lines
        \linethickness{0.5pt}%
        \put(37,740){\line(1,0){540}}
        % Vertical lines
        \put(307,133){\line(0,1){590}}
        % SF 298 classification
        \fontsize{11pt}{12pt}\selectfont%
        \put(20,775){\makebox(574,14){\bfseries\@sfClassification}}
        \put(20,05){\makebox(574,14){\bfseries\@sfClassification}}
        % Text labels
        \fontsize{10pt}{11pt}\selectfont%
        \put(197,745){\makebox(220,20){\bfseries%
            INSTRUCTIONS FOR COMPLETING SF 298}}
        % Left column of text
        \fontsize{10pt}{11pt}\selectfont%
        \put(24,710){\parbox[t][580pt][t]{265pt}{%
            \textbf{1. REPORT DATE.}\\[1pt]
            Full publication date, including day,\, month, if available.\\
            Must cite at least the year and be
                Year\, 2000 compliant, e.g.\\[2pt]
            30-06-1998; xx-06-1998; xx-xx-1998.\\[13pt]
            \textbf{2. REPORT TYPE.}\\[1pt]
            State the type of report, such as final, technical, interim,\\[1pt]
            memorandum, master's thesis, progress, quarterly,\\[1pt]
            research, special, group study,\, etc.\\[13pt]
            \textbf{3. DATES\, COVERED.}\\[1pt]
            Indicate the time during which the work was performed and\\[1pt]
            the\,report was written.\\[13pt]
            \textbf{4. TITLE.}\\[1pt]
            Enter title and subtitle with volume number and part\\[1pt]
            number, if applicable.\,\,On classified documents, enter the\\[1pt]
            title classification in parentheses.\\[13pt]
            \textbf{5a. CONTRACT NUMBER.}\\[1pt]
            Enter all contract numbers as they appear in the report, e.g.\\[1pt]
            F33615-86-C-5169.\\[13pt]
            \textbf{5b. GRANT NUMBER.}\\[1pt]
            Enter all grant numbers as they appear in the report, e.g.\\[1pt]
            AFOSR-82-1234.\\[13pt]
            \textbf{5c. PROGRAM ELEMENT NUMBER.}\\[1pt]
            Enter all program element numbers as they appear in the\\[2pt]
            report, e.g. 61101A\\[12pt]
            \textbf{5d. PROJECT NUMBER.}\\[2pt]
            Enter all project numbers as they appear in the report, e.g.\\[1pt]
            1F665702D1257; ILIR.\\[12pt]
            \textbf{5e. TASK NUMBER.}\,\,Enter
                all task numbers as they appear\\[2pt]
            in the report, e.g. 05; RF0330201; T4112.\\[13pt]
            \textbf{5f. WORK UNIT NUMBER.}\\[1pt]
            Enter all work unit numbers as they appear in the report,\\[1pt]
            e.g. 001;\,\,AFAPL30480105.\\[13pt]
            \textbf{6. AUTHOR(S).} Enter name(s) of person(s)\\[1pt]
            responsible for writing the report, performing the\\[1pt]
            research, or credited with the content of the report. The\\[1pt]
            form of entry is the last name, first name, middle initial,\\[1pt]
            and additional qualifiers separated by commas, e.g.\\[1pt]
            Smith, Richard, J, Jr.}}
        % Right column of text
        \put(325,710){\parbox[t][580pt][t]{265pt}{%
            \textbf{7. PERFORMING ORGANIZATION\, NAME(S) AND}\\[2pt]
            \textbf{ADDRESS(ES).} Self-explanatory.\\[13pt]
            \textbf{8. PERFORMING ORGANIZATION\, REPORT NUMBER.}\\[1pt]
            Enter all unique alphanumeric report numbers assigned by\\[1pt]
            the performing organization, e.g. BRL-1234; AFWL-\\[1pt]
            TR-85-4017-Vol\,-21-PT-2.\\[13pt]
            \textbf{9. SPONSORING/MONITORING\,\,AGENCY NAME(S)}\\[1pt]
            \textbf{AND ADDRESS(ES).} Enter the name and address of the\\[1pt]
            organization(s) financially responsible\,\,for and monitoring\\[1pt]
            the work.\\[13pt]
            \textbf{10. SPONSOR/MONITOR'S ACRONYM(S).}\, Enter, if\\[1pt]
            available, e.g.\, BRL, ARDEC, NADC.\\[13pt]
            \textbf{11. SPONSOR/MONITOR'S REPORT NUMBER(S).} Enter\\[1pt]
            report number as assigned by the sponsoring/monitoring\\[2pt]
            agency,\, if available, e.g. BRL-TR-829;\,\,-215.\\[13pt]
            \textbf{12. DISTRIBUTION/\,AVAILABILITY\, STATEMENT.}\, Use\\[1pt]
            agency-mandated\,\,availability statements to indicate the\\[1pt]
            public\,\,availability or distribution limitations
                of the report. If\\[1pt]
            additional limitations/ restrictions or special markings are\\[1pt]
            indicated,\,\,follow agency
                authorization procedures, e.g. RD/\\[1pt]
            FRD,\,\,PROPIN,\,\,ITAR,\,\,etc.\,\,Include
                copyright information.\\[13pt]
            \textbf{13. SUPPLEMENTARY\, NOTES.} Enter information not\\[1pt]
            included elsewhere such as: prepared in cooperation with;\\[1pt]
            translation of; report supersedes; old edition number, etc.\\[13pt]
            \textbf{14. ABSTRACT.}\, A brief
                (approximately 200 words) factual\\[1pt]
            summary of the most significant information.\\[13pt]
            \textbf{15. SUBJECT TERMS.}\,\,Key words
                or phrases identifying\\[1pt]
            major concepts in the report.\\[13pt]
            \textbf{16. SECURITY CLASSIFICATION.}\,\,Enter security\\[1pt]
            classification in accordance with security classification\\[1pt]
            regulations, e.g. U,\,\,C,\,\,S,\,\,etc.
                If this form contains\\[1pt]
            classified information, stamp classification\,\,level
                on the top\\[1pt]
            and bottom of this page.\\[13pt]
            \textbf{17. LIMITATION\, OF ABSTRACT.}\, This block must be\\[1pt]
            completed to assign a distribution limitation
                to the abstract.\\[1pt]
            Enter UU (Unclassified Unlimited) or SAR (Same as\\[1pt]
            Report). An entry in this block is
                necessary if the abstract is\\[1pt]
            to be limited.}}
        % Footer
        \fontsize{8pt}{9pt}\selectfont%
        \put(20,23){\makebox(40,10)[tl]{\mdseries\,Page 2 of 2}}
        \put(20,18){\makebox(574,10){\mdseries PREVIOUS EDITION IS OBSOLETE.}}
        \put(419,20){\makebox(179,10)[tr]{%
            \bfseries\fontsize{10pt}{11pt}\selectfont%
            STANDARD FORM 298 (REV.\,\ 5/2020)}}
        \put(419,9){\makebox(179,10)[tr]
            {\mdseries\itshape Prescribed by ANSI Std. Z39.18}}
    \end{picture}\restoregeometry\clearpage}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{WindolonBook}[2023/10/30 The Windolon Book Class]

% WindolonBook.cls
%
% My own class for typesetting a book-like document in LaTeX
% with a custom style and many enhanced theorem environment
% features. A lot of design and features inspiration is due to
% the book Linear Algebra and its author Jim Hefferon, who
% provided the source code to the public. I cannot be more grateful
% for that.
%
% HOW TO USE
%   Include the class in \documentclass. The class functions
%   identically to the default book class in terms of options.
%   Compile your .tex file using at least pdflatex * 2.
%   I personally use pdflatex * 3.
%   I haven't tested this class for other compilation methods.
%
% HISTORY
%   25.7.2023
%       Work on the class started.
%   26.8.2023
%       First functioning version completed. The class features
%       custom layout, theorem styles and chapter title.
%   19.9.2023
%       The class supports exercises and answers environments.
%       Problems can be divided into parts using the
%       exparts or exparts* environments.
%   25.9.2023
%       Added automatic pdf navigation when starting
%       unnumbered chapters.
%   16.9.2023
%       Bunch of appearance fixes: Most notable one is
%       displayed equation padding in exparts environment.
%   30.10.2023
%       Added header style for unnumbered chapters so that
%       it no longer bugs out. Also added code listings
%       functionalities with listings package.

% ==============================================================================
%         PRELIMINARY CONFIGURATIONS
% ==============================================================================

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}} % Pass through any entered options to the base book class
\ProcessOptions\relax % Execute options

\LoadClass{book} % Loads the base book class

% ==============================================================================
%         FONTS, PAGE AND MARGINS
% ==============================================================================

\usepackage[nomath,nosf]{kpfonts} % Kp-Fonts as the default serif font for ordinary text, family name: jkp
% Kp-Fonts doesn't modify fonts for maths mode & sans serif fonts (just for compatibility safety) with nomath and nosf
% LaTeX will complain about Kp-Font's maths font shapes being unavailable.
% Since the class doesn't intend to use its maths font, there's no need to worry.

\usepackage[mathbf]{euler} % AMS Euler for maths environments
% mathbf option used to replace Computer Modern boldface with AMS Euler boldface in \mathbf

\usepackage{cabin} % Cabin as the default sans serif font for headers, titles and what not, family name: cbn

\usepackage{microtype} % Improves overall typography

% Setting up page and margins using geometry package
\usepackage[
    papersize={20cm,25cm}, % Actual size of paper
    top=2.25cm, bottom=2.25cm, % Top and bottom margin
    inner=2.8cm, % Inner margin: right margin on even numbered pages and vice versa; left margin in oneside mode
    outer=2.8cm, % Outer margin: opposite to inner margin
    headsep=12pt, % Space from the top margin to the baseline of the header
    %showframe % Show typing frames for debugging
]{geometry}

% Set line spacing to a more comfortable setting
\usepackage{setspace}
\setstretch{1.1}

\usepackage{emptypage} % Make auto-empty pages really empty, such as empty page offsets between chapters

% ==============================================================================
%         HEADERS AND FOOTERS
% ==============================================================================

\usepackage{fancyhdr} % Enables custom headers and footers
\setlength{\headheight}{15pt} % See https://www.overleaf.com/learn/latex/Page_size_and_margins

% ===== Define different header / footer styles for different parts of the book =====

% Main body of the book
\fancypagestyle{mainbody}{
    \fancyhf{} % Clears all default headers and footers
    \renewcommand{\headrulewidth}{0.4pt} % Header rule thickness
    \renewcommand{\footrulewidth}{0pt} % Disable footer rule
    \fancyhead[LE, RO]{\sffamily\thepage} % Page number at left of even pages, right of odd pages
    \fancyhead[RE]{\sffamily\nouppercase{\leftmark}} % Chapter title at right of even pages
    \fancyhead[LO]{\sffamily\nouppercase{Section \rightmark}} % Section title at left of odd pages
}

% Main body, but unnumbered chapters
\fancypagestyle{mainbody*}{
    \fancyhf{}
    \renewcommand{\headrulewidth}{0pt} % Disable header rule
    \renewcommand{\footrulewidth}{0pt}
    \fancyhead[LE,RO]{\sffamily\thepage}
    \fancyhead[RE]{\sffamily\itshape{\booktitle}} % Book title at right of even pages
    \fancyhead[LO]{\sffamily\itshape{\unnumchaptername}} % Chapter title at left of odd pages
}

% Redefine plain style to clear everything
\fancypagestyle{plain}{
    \fancyhf{}
    \renewcommand{\headrulewidth}{0pt}
    \renewcommand{\footrulewidth}{0pt}
}

% ==============================================================================
%         THEOREM STYLINGS
% ==============================================================================

\usepackage{amsmath, amsthm, amsfonts, MnSymbol} % Handy maths packages
\usepackage{thmtools} % To customise theorem environments
\usepackage[x11names]{xcolor} % Allows colour control; x11names gives loads of cool new colours

% ===== Define different theorem styles for definition, propositions, etc. =====

% I defined seven different coloured boxes (according to the rainbow, ROYGBIV) for the usual maths objects,
% a simple text style for examples and remarks and a modified proof style adapted from
% Jim Hefferon's Linear Algebra.

\declaretheoremstyle[
    preheadhook={\vskip7pt}, postfoothook={\vskip7pt}, % Spaces above and below a theorem box
    headfont=\color{DarkGoldenrod3!50!DarkGoldenrod4}\sffamily\bfseries, % Theorem head
    notefont=\normalcolor\sffamily\bfseries, notebraces={}{}, % Theorem note formatting
    bodyfont=\normalfont, % Body text
    headpunct={\vspace{7pt}\newline}, % Dedicate entire first line to theorem head + notes
    % Also adds 5pt vertical space between first line and subsequent lines
    headformat={\NUMBER\ \NAME\quad\NOTE}, % Theorem head displays like "2.3 Theorem    Name of theorem"
    mdframed={ % Uses mdframed options for greater customisation, see mdframed package documentation for details
        backgroundcolor=LightGoldenrod1!20, % Shades the theorem box slightly yellow
        hidealllines=true, % Remove border lines around the box
        innerleftmargin=7pt, innerrightmargin=7pt, innertopmargin=7pt, innerbottommargin=7pt % Inner margin sizes
    }
]{yellow}

\declaretheoremstyle[
    preheadhook={\vskip7pt}, postfoothook={\vskip7pt},
    headfont=\color{Maroon0}\sffamily\bfseries,
    notefont=\normalcolor\sffamily\bfseries, notebraces={}{},
    bodyfont=\normalfont,
    headpunct={\vspace{7pt}\newline},
    headformat={\NUMBER\ \NAME\quad\NOTE},
    mdframed={
        backgroundcolor=Firebrick2!8,
        hidealllines=true,
        innerleftmargin=7pt, innerrightmargin=7pt, innertopmargin=7pt, innerbottommargin=7pt
    }
]{red}

\declaretheoremstyle[
    preheadhook={\vskip7pt}, postfoothook={\vskip7pt},
    headfont=\color{Sienna3!60!Sienna4}\sffamily\bfseries,
    notefont=\normalcolor\sffamily\bfseries, notebraces={}{},
    bodyfont=\normalfont,
    headpunct={\vspace{7pt}\newline},
    headformat={\NUMBER\ \NAME\quad\NOTE},
    mdframed={
        backgroundcolor=Sienna1!12,
        hidealllines=true,
        innerleftmargin=7pt, innerrightmargin=7pt, innertopmargin=7pt, innerbottommargin=7pt
    }
]{orange}

\declaretheoremstyle[
    preheadhook={\vskip7pt}, postfoothook={\vskip7pt},
    headfont=\color{Chartreuse4}\sffamily\bfseries,
    notefont=\normalcolor\sffamily\bfseries, notebraces={}{},
    bodyfont=\normalfont,
    headpunct={\vspace{7pt}\newline},
    headformat={\NUMBER\ \NAME\quad\NOTE},
    mdframed={
        backgroundcolor=Chartreuse1!10,
        hidealllines=true,
        innerleftmargin=7pt, innerrightmargin=7pt, innertopmargin=7pt, innerbottommargin=7pt
    }
]{green}

\declaretheoremstyle[
    preheadhook={\vskip7pt}, postfoothook={\vskip7pt},
    headfont=\color{CadetBlue3!20!CadetBlue4}\sffamily\bfseries,
    notefont=\normalcolor\sffamily\bfseries, notebraces={}{},
    bodyfont=\normalfont,
    headpunct={\vspace{7pt}\newline},
    headformat={\NUMBER\ \NAME\quad\NOTE},
    mdframed={
        backgroundcolor=CadetBlue1!15,
        hidealllines=true,
        innerleftmargin=7pt, innerrightmargin=7pt, innertopmargin=7pt, innerbottommargin=7pt
    }
]{blue}

\declaretheoremstyle[
    preheadhook={\vskip7pt}, postfoothook={\vskip7pt},
    headfont=\color{RoyalBlue3!50!RoyalBlue4}\sffamily\bfseries,
    notefont=\normalcolor\sffamily\bfseries, notebraces={}{},
    bodyfont=\normalfont,
    headpunct={\vspace{7pt}\newline},
    headformat={\NUMBER\ \NAME\quad\NOTE},
    mdframed={
        backgroundcolor=RoyalBlue1!8,
        hidealllines=true,
        innerleftmargin=7pt, innerrightmargin=7pt, innertopmargin=7pt, innerbottommargin=7pt
    }
]{indigo}

\declaretheoremstyle[
    preheadhook={\vskip7pt}, postfoothook={\vskip7pt},
    headfont=\color{MediumPurple3!50!MediumPurple4}\sffamily\bfseries,
    notefont=\normalcolor\sffamily\bfseries, notebraces={}{},
    bodyfont=\normalfont,
    headpunct={\vspace{7pt}\newline},
    headformat={\NUMBER\ \NAME\quad\NOTE},
    mdframed={
        backgroundcolor=SlateBlue1!10,
        hidealllines=true,
        innerleftmargin=7pt, innerrightmargin=7pt, innertopmargin=7pt, innerbottommargin=7pt
    }
]{violet}

\declaretheoremstyle[
    headfont=\sffamily\bfseries,
    notefont=\sffamily\bfseries, notebraces={ (}{)}, % Likely unused because I rarely put thm notes in examples, but defined nonetheless.
    bodyfont=\normalfont,
    headpunct={\ }, % Allows some space between theorem head and upcoming text
    headformat={\NUMBER\ \NAME\NOTE}
]{text} % vscode complains about unclosed parentheses, etc. (red highlights) but it's fine.

% Redefine proof environment entirely. Adapted from Jim Hefferon's Linear Algebra.
\let\proof\@undefined
\let\endproof\@undefined
\renewcommand{\proofname}{{\scshape\small Proof}} % Replaces default italic with small caps
\renewcommand{\qedsymbol}{{\scshape\small QED}} % Replaces default tombstone end of proof symbol with small caps QED
% (Yes. That square is called tombstone. Look it up!)
\declaretheoremstyle[
    headfont=\normalfont\small\scshape,
    notefont=\normalfont\small\scshape, notebraces={ (}{)},
    bodyfont=\normalfont,
    headpunct={\quad},
    headformat={\NAME\NOTE},
    prefoothook={\hfill\qedsymbol}
]{pf} % Ditto about unclosed brackets and stuff.

% ===== Properly declare theorem environments matching their styles =====

\declaretheorem[
    name=Theorem, % Theorem display name
    style=yellow, % Theorem style
    numberwithin=chapter % Theorem numbering
]{theorem}

\declaretheorem[
    name=Proposition,
    style=blue,
    sibling=theorem % All subsequent theorem numbering shares the same counter
]{proposition}

\declaretheorem[
    name=Lemma,
    style=violet,
    sibling=theorem
]{lemma}

\declaretheorem[
    name=Corollary,
    style=indigo,
    sibling=theorem
]{corollary}

\declaretheorem[
    name=Definition,
    style=red,
    sibling=theorem
]{definition}

\declaretheorem[
    name=Claim,
    style=orange,
    sibling=theorem
]{claim}

\declaretheorem[
    name=Notation,
    style=green,
    sibling=theorem
]{notation}

\declaretheorem[
    name=Example,
    style=text,
    sibling=theorem
]{example}

\declaretheorem[
    name=Remark,
    style=text,
    sibling=theorem
]{remark}

\declaretheorem[
    name=Proof,
    style=pf,
    numberwithin=chapter % proofs won't take up theorem numbering
]{proof}

% ===== Code listings environment =====

\usepackage{listings}
\lstset{
    basicstyle=\ttfamily\small,
    backgroundcolor=\color{LightGoldenrod1!20},
    showstringspaces=false,
    aboveskip=7pt,
    belowskip=7pt
}

% ==============================================================================
%         SECTIONAL TITLES STYLINGS
% ==============================================================================

\renewcommand{\thesection}{\thechapter.\Alph{section}} % Changes section labels display to, e.g. "2.B"
\renewcommand{\thesubsection}{\thechapter.\Alph{section}.\Roman{subsection}} % Changes subsection labels display to, e.g. "3.A.I"

\usepackage[explicit]{titlesec} % titlesec package used to fine tune stylings of sectional titles
\usepackage{tikz} % Grants the power to draw stuff on the page, needed for chapter title style
\usetikzlibrary{calc} % Needed for tikz node coordinates calculations
\usepackage{fmtcount} % Allows \Numberstring command to display counter as, e.g. "Fourteen"
\usepackage{varwidth} % Needed for chapter titles not exceeding the right margin

\titleformat{\section} % Sectioning command to be redefined
    [hang] % Title shape, default shape is hang (i.e. I kept the default shape, nothing too fancy)
    {\sffamily\bfseries\Large} % Format to be applied to the whole title, both label and text
    {\thesection} % Section label (is ignored in starred versions of the sectioning command, as it should be)
    {1em} % Horizontal separation between the label and title body (is ignored in starred sections)
    {#1} % Code preceding the title body, but in all honesty this is simply the title itself
    [] % Code following the title body
\titlespacing*{\section}{0pt}{35pt}{12pt} % Spacings around the sectional title; left, before-sep, after-sep
% The star is needed to prevent indentation in the first paragraph

\titleformat{\subsection}
    [hang]
    {\sffamily\bfseries\large}
    {\thesubsection}
    {1em}
    {#1}
    []
\titlespacing*{\subsection}{0pt}{35pt}{12pt}

\titleformat{\subsubsection}
    [hang]
    {\sffamily\bfseries}
    {\thesubsubsection}
    {1em}
    {#1}
    []
\titlespacing*{\subsubsection}{0pt}{12pt}{12pt}

% Helper command to display a leading zero if a given counter is below 10 (arabic numbers)
\newcommand{\leadingzero}[1]{\ifnum\value{#1}<10 0\fi\arabic{#1}}

% Define a new command to output a simple chapter heading
% with chapter numbering & icon in the style of Tokyo metro stations
\newcommand{\tyometrosty}[1]{
    \begin{tikzpicture}[remember picture,overlay]
        \fill [accent!40] (current page.north west) rectangle (17.2,-1); % Creates the colour band on top of page

        \draw [ % Draws an accent-coloured thick line at exactly the bottom edge of the band
            accent, % Line colour
            line width=7pt % Thickness of the line
        ] (-2.8,-1) -- (17.2,-1);

        \node [ % Draws an accent-coloured circle with white background on the line
            circle, % Draws a circle
            draw=accent, % Circle border colour
            fill=white, % Fills the inside with white colour
            line width=7pt, % Border thickness
            minimum size=2.75cm % Size of the circle
        ] (chIcon) at (0.3,-1) {};

        \node [ % Node for chapter number placed on the lower half of chIcon
            above=0.5cm % Place text 0.5cm above the node
        ] (chNum) at (chIcon.270) {\sffamily\bfseries\fontsize{38}{0}\selectfont\leadingzero{chapter}};

        \node [ % Node for book alias placed on the upper half of chIcon
            below=0.36cm
        ] (chAlias) at (chIcon.90) {\sffamily\bfseries\fontsize{28}{0}\selectfont\bookinit};

        \node [ % Node for the "Chapter One" text
            right=0.75cm
        ] (chNumText) at (chIcon.23) {\sffamily\bfseries\scshape\Huge Chapter \Numberstring{chapter}};

        \node [ % Node for the chapter title
            below right,
            yshift=-0.75cm % Shift text downwards by 1.3cm
        ] (chName) at (chNumText.west) {\begin{varwidth}{11.975cm}\sffamily\bfseries\scshape\fontsize{30}{26}\selectfont #1\end{varwidth}};

        % Chapter titles will span multiple lines as they get longer.
        % Due to this tikzpicture being an overlay, a constant vertical space below the chapter display
        % will result in uneven spacing after the chapter title. The following line records
        % the vertical distance between the top and bottom of the chName node.
        \path let \p1=($(chName.north)-(chName.south)$) in \pgfextra{\xdef\thtyo{\y1}};
    \end{tikzpicture}
    
    \vspace*{\thtyo} % Adds vertical distance equal to that between the top and bottom of the chName node
    \vspace*{-1cm} % Subtracts the vertical distance of one text line to keep display consistent
}

% The numberless variant of the style
\newcommand{\tyometrostyx}[1]{
    \pdfbookmark[0]{#1}{unnumbered} % Adds a pdf navigation destination

    \begin{tikzpicture}[remember picture,overlay]
        \fill [accent!40] (current page.north west) rectangle (17.2,-1);

        \draw [
            accent,
            line width=7pt
        ] (-2.8,-1) -- (17.2,-1);

        \node [
            circle,
            draw=accent,
            fill=white,
            line width=16pt,
            minimum size=2.4cm
        ] (chIcon) at (0.3,-1) {\sffamily\bfseries\fontsize{48}{0}\selectfont\bookinit};

        \node [
            right=0.75cm
        ] (chNumText) at (chIcon.23) {\sffamily\bfseries\scshape\Huge Chapter};

        \node [
            below right,
            yshift=-0.75cm
        ] (chName) at (chNumText.west) {\begin{varwidth}{11.975cm}\sffamily\bfseries\scshape\fontsize{30}{26}\selectfont #1\end{varwidth}};

        \path let \p1=($(chName.north)-(chName.south)$) in \pgfextra{\xdef\thtyox{\y1}};
    \end{tikzpicture}

    \vspace*{\thtyox}
    \vspace*{-1cm}
}

\titleformat{\chapter}
    [block] % Needs block shape to function properly, also the shape makes more sense
    {\tyometrosty{#1}} % This will define the chapter heading style
    {} % All of the following arguments should be empty or null because the preceding argument takes care of everything
    {0cm}
    {}
    []

\titleformat{name=\chapter, numberless} % We'll need a style separate for unnumbered chapters because of how we handle stylings
    [block]
    {\tyometrostyx{#1}}
    {}
    {0cm}
    {}
    []
%
\titlespacing*{\chapter}{0pt}{0pt}{3.5cm}

% ==============================================================================
%         EXERCISES & ANSWERS ENVIRONMENT
% ==============================================================================

\usepackage{hyperref} % Create hyperlinks within the document for superb navigation

\hypersetup{ % hyperref setup
    colorlinks=true, % Colourise links
    allcolors=RoyalBlue4, % Colour for \ref type links
    linktoc=all, % Link section names and page numbers in table of contents
    pdfpagemode=UseOutlines % Allows pdf viewer to have table of contents-like navigation on the left sidebar
}

\newcounter{ex-ansitemcounter}
% This command creates a unique hypertarget identifier for a problem while preparing to link to the answer
\newcommand{\hyperproblemside}[1]{\hyperlink{ex:\arabic{chapter}-\arabic{section}-\arabic{subsection}-\arabic{#1}-S}{\hypertarget{ex:\arabic{chapter}-\arabic{section}-\arabic{subsection}-\arabic{#1}-P}{\arabic{#1}}}}
% This command complements the above
\newcommand{\hypersolutionsside}[4]{\hypertarget{ex:#1-#2-#3-\arabic{#4}-S}{\hyperlink{ex:#1-#2-#3-\arabic{#4}-P}{\arabic{#4}}}}
% This helper command makes a list label be typed in boldface sans serif
\newcommand{\bfsflabel}[1]{\bfseries\sffamily #1\hfill}

\newenvironment{exlist}{
    \begin{list}{\hyperproblemside{ex-ansitemcounter}}{
        \usecounter{ex-ansitemcounter}
        \setlength{\leftmargin}{\parindent} % See https://www.overleaf.com/learn/latex/Lists#LaTeX_list_parameters
        \setlength{\rightmargin}{0cm}
        \setlength{\parsep}{\parskip}
        \setlength{\itemsep}{5pt}
        \setlength{\itemindent}{0pt}
        \setlength{\listparindent}{\parindent}
        \setlength{\topsep}{7pt}
        \setlength{\partopsep}{2pt}
        \setlength{\labelsep}{4pt}
        \setlength{\labelwidth}{1em}
        \setlength{\abovedisplayskip}{7pt}
        \setlength{\belowdisplayskip}{7pt}
        \setlength{\abovedisplayshortskip}{4pt}
        \setlength{\belowdisplayshortskip}{4pt}
        \renewcommand{\makelabel}{\bfsflabel}
    }
}{\end{list}}

% "exercises" environment usage:
% \begin{exercises}
%     \item ...
% \end{exercises}
% Please only begin at most one exercise environment per subsection,
% because the auto hyperlink pairs will break.
% (Not that the need for two or more exercise envs per subsection is that big.)
\newenvironment{exercises}{
    \bigbreak
    \noindent{\sffamily\textbf{Exercises}}
    \begingroup\@beginparpenalty 10000
    \small
    \begin{exlist}
}{\end{exlist}\endgroup\pagebreak[2]}

\newenvironment{anslist}[3]{
    \begin{list}{\hypersolutionsside{#1}{#2}{#3}{ex-ansitemcounter}}{
        \usecounter{ex-ansitemcounter}
        \setlength{\leftmargin}{\parindent}
        \setlength{\rightmargin}{0cm}
        \setlength{\parsep}{\parskip}
        \setlength{\itemsep}{5pt}
        \setlength{\itemindent}{0pt}
        \setlength{\listparindent}{\parindent}
        \setlength{\topsep}{0pt}
        \setlength{\partopsep}{2pt}
        \setlength{\labelsep}{4pt}
        \setlength{\labelwidth}{1em}
        \setlength{\abovedisplayskip}{0pt}
        \setlength{\belowdisplayskip}{0pt}
        \setlength{\abovedisplayshortskip}{0pt}
        \setlength{\belowdisplayshortskip}{0pt}
        \renewcommand{\makelabel}{\bfsflabel}
    }
}{\end{list}}

% "answers" environment usage:
% \begin{answers}{(chapter number that the group of exercises is located)}{(section number)}{(subsection number)}
%     \item ...
% \end{answers}
% The three arguments must be typed for proper hyperlinking.
% Note: Only numbers are accepted as arguments. (i.e. for subsection 1.B.III you pass \begin{answers}{1}{2}{3}.)
\newenvironment{answers}[3]{
    \begin{anslist}{#1}{#2}{#3}
}{\end{anslist}}

% "exparts" environment for problems with subparts. Adapted from Jim Hefferon's Linear Algebra.
% "exparts" prints subparts from top to bottom:
% (a) ...
% (b) ...
% and "exparts*" prints them across:
% (a) ... (b) ... (c) ...

\newcounter{expartscounter}
\newenvironment{expartslist}{
    \begin{list}{(\alph{expartscounter})}{
        \usecounter{expartscounter}
        \setlength{\leftmargin}{1em}
        \setlength{\rightmargin}{0cm}
        \setlength{\listparindent}{\parindent}
        \setlength{\itemindent}{0pt}
        \setlength{\labelsep}{0.4em}
        \setlength{\labelwidth}{0pt}
        \setlength{\topsep}{0pt}
        \setlength{\parskip}{0pt}
        \setlength{\partopsep}{0pt}
        \setlength{\parsep}{.1ex}
        \setlength{\itemsep}{0pt}
        \setlength{\abovedisplayskip}{5pt}
        \setlength{\belowdisplayskip}{5pt}
        \setlength{\abovedisplayshortskip}{5pt}
        \setlength{\belowdisplayshortskip}{5pt}
        \renewcommand{\makelabel}{\bfsflabel}
    }
}{\end{list}}

% Usage:
% \begin{exparts}
%     \partitem ...
% \end{exparts}
\newenvironment{exparts}{
    \def\partitem{\item\relax}
    \begin{expartslist}
}{\end{expartslist}}

% Thanks to Jim Hefferon for giving a solution to this magic of printing lists across.
\newenvironment{exparts*}{
    \def\partitem{\penalty-400\hskip1.25em\relax\hbox{\refstepcounter{expartscounter}{\bfseries\sffamily(\alph{expartscounter})}\hspace*{.5em}}\nobreak}
    \begin{expartslist}
    \setlength{\itemindent}{-1.65em}
    \rightskip=0pt plus.25\textwidth\spaceskip=.3333em\xspaceskip=.5em\relax
    \item[]
}{\end{expartslist}}

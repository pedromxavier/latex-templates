\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{homework}[2020/06/30 Homework LaTeX class]
%% ------------------------------------------------------------------------
%% ------------------------------------------------------------------------
%% ------------------------------------------------------------------------

\RequirePackage{ifthen}

%% Language
\def\userlang{en}
\def\babellang{english}

\DeclareOption{brazil}{
	\def\userlang{br}
	\def\babellang{brazil}
}

\DeclareOption{english}{
	\def\userlang{en}
	\def\babellang{english}
}

%% Tikz

\def\usetikz{0}%%
\DeclareOption{tikzdraw}{ %% Tikz + Pgf
	\def\usetikz{1}%%
}

\newboolean{hideanswers}
\setboolean{hideanswers}{true}
\DeclareOption{answer}{ %% Show answers
	\setboolean{hideanswers}{false}%%
}

%% Line Spacing

\def\uselinespread{1.0}%%
\DeclareOption{single}{%%
	\def\uselinespread{1.0}%%
}

\DeclareOption{middle}{%%
	\def\uselinespread{1.3}%%
}


\DeclareOption{double}{%%
	\def\uselinespread{1.6}%%
}

%% Font Size

\def\useinvert{0}%%
\DeclareOption{invert}{%%
	\def\useinvert{1}%%
}

\DeclareOption*{%%
	\OptionNotUsed%%
}
\ProcessOptions\relax

\LoadClass{article}

\RequirePackage{comment}
\RequirePackage{graphicx}
\RequirePackage{xcolor}
\RequirePackage{listings}
\RequirePackage[utf8]{inputenc}
\RequirePackage{multicol}
\RequirePackage{float}
\RequirePackage{environ}
\RequirePackage{suffix}
\RequirePackage{enumitem}
\RequirePackage{scalerel}
\RequirePackage[skins,breakable]{tcolorbox}
\RequirePackage[symbol]{footmisc}
\RequirePackage[a4paper, margin=2cm]{geometry}

\RequirePackage[\babellang]{babel}
\RequirePackage{translator}

%% Self Package
\RequirePackage{homework}

%% Tikz Import stuff
\newcommand{\wallpaper}[1]{} %% Dummy, to be redefined 
\if\usetikz1
	%% Import Packages
	\RequirePackage{tikz}
	\RequirePackage{pgfplots}

	%% Tikz Libraries
	\usetikzlibrary{backgrounds}
	\usetikzlibrary{positioning}
	\usetikzlibrary{arrows}
	\usetikzlibrary{quotes}
	\usetikzlibrary{angles}
	\usetikzlibrary{shapes, shapes.geometric, shapes.misc}
	
	%% default styles for simples graphs
	\tikzstyle{t}=[font=\huge]
	\tikzstyle{v}=[circle, draw, inner sep=0pt, minimum size=12pt]
	\tikzstyle{e}=[black!80]
	\tikzstyle{a}=[font=\color{blue!80}, draw=blue!80, angle eccentricity=1.5, angle radius=15pt]

	%% Tikzit Support

	% this style is applied by default to any tikzpicture included via \tikzfig
	\tikzstyle{tikzfig}=[baseline=-0.25em,scale=0.5]

	% these are dummy properties used by TikZiT, but ignored by LaTex
	\pgfkeys{/tikz/tikzit fill/.initial=0}
	\pgfkeys{/tikz/tikzit draw/.initial=0}
	\pgfkeys{/tikz/tikzit shape/.initial=0}
	\pgfkeys{/tikz/tikzit category/.initial=0}

	% standard layers used in .tikz files
	\pgfdeclarelayer{background}
	\pgfdeclarelayer{edgelayer}
	\pgfdeclarelayer{nodelayer}
	\pgfsetlayers{background, edgelayer, nodelayer, main}

	% style for blank nodes
	\tikzstyle{none}=[inner sep=0mm]

	% Include style
	\input{graph.tikzstyles}

	% include a .tikz file
	\newcommand{\tikzfig}[1]{%
	{\tikzstyle{every picture}=[tikzfig]
	\IfFileExists{#1.tikz}
	{\input{#1.tikz}}
	{%
		\IfFileExists{./figures/#1.tikz}
		{\input{./figures/#1.tikz}}
		{\tikz[baseline=-0.5em]{\node[draw=red,font=\color{red},fill=red!10!white] {\textit{#1}};}}%
	}}%
	}

	% the same as \tikzfig, but in a {center} environment
	\newcommand{\ctikzfig}[1]{%
	\begin{center}\rm
	\tikzfig{#1}
	\end{center}}

	% fix strange self-loops, which are PGF/TikZ default
	\tikzstyle{every loop}=[]

	%% Compatibility issues
	\pgfplotsset{compat=1.16}

	%% Tikz Helper Functions
	\newcommand\tkangle[4][\empty]{%%
		\draw pic[#1, a]{angle=#2--#3--#4};%%
	}
	%%

	%% Wallpaper command
	\renewcommand{\wallpaper}[1]{%%
		\tikz[remember picture,overlay] \node[opacity=0.75,inner sep=0pt] at (current page.center){\includegraphics[width=\paperwidth,height=\paperheight]{#1}};
	}
\fi

%%
\definecolor{darkbgcolor}{rgb}{0.000, 0.000, 0.090}
\definecolor{darkfgcolor}{rgb}{0.900, 0.900, 0.900}

\definecolor{lightbgcolor}{rgb}{1.000, 1.000, 1.000}
\definecolor{lightfgcolor}{rgb}{0.000, 0.000, 0.000}

\if\useinvert1%%
	\def\bgcolor{darkbgcolor}
	\def\fgcolor{darkfgcolor}
\else%%
	\def\bgcolor{lightbgcolor}
	\def\fgcolor{lightfgcolor}
\fi
\pagecolor{\bgcolor}
\color{\fgcolor}

%% Translation
\uselanguage{\userlang}
\languagepath{\userlang}

\deftranslation[to=br]{Question}{Questão}

%% Math declaration stuff
\DeclarePairedDelimiter\ceil{\lceil}{\rceil}
\DeclarePairedDelimiter\floor{\lfloor}{\rfloor}
\DeclareMathOperator*{\argmax}{arg\,max}
\DeclareMathOperator*{\argmin}{arg\,min}

%% Custom footnotes
% 1   asterisk        *   2   dagger      †   3   double dagger       ‡
% 4   section symbol  §   5   paragraph   ¶   6   parallel lines      ‖
% 7   two asterisks   **  8   two daggers ††  9   two double daggers  ‡‡
\renewcommand{\thefootnote}{\fnsymbol{footnote}}

%% Set some things
\linespread{\uselinespread}
\setlength{\parindent}{0em}
\setlength{\parskip}{1em}
\setlength{\voffset}{-0.5in}
\setlength{\textheight}{720pt}
\setlength{\jot}{1ex}
\setlist[itemize]{leftmargin=50pt}

%% Registers
\def \@register {\empty}
\newcommand{\register}[1]{%%
	\def \@register {#1}
}

\def \@subtitle {\empty}
\newcommand{\subtitle}[1]{%%
	\def \@subtitle {#1}
}

%% Counters
\newcounter{quests}
\newcounter{subquests}
\newcounter{subsubquests}
\newcounter{figs}

\setcounter{quests}{0}
\setcounter{subquests}{0}
\setcounter{subsubquests}{0}
\setcounter{figs}{0}

\renewcommand{\thesubquests}{%%
	\arabic{subquests}
}

\renewcommand{\thesubsubquests}{%%
	\alph{subsubquests}
}

%% Commands
\newcommand{\quest}[1]{%%
	\stepcounter{quests}
	\setcounter{subquests}{0}
	\setcounter{subsubquests}{0}
	\setcounter{figs}{0}
	\ifempty{#1}{%%
		\def\thisquest{\unskip}%
	}{%%
		\def\thisquest{.: {\normalfont#1}}%
	}
    \newpage{\bfseries{\bfseries \translate[to=\userlang]{Question} \thequests}\thisquest\par\addvspace{1ex}}%%
}

\WithSuffix\newcommand\quest*[1]{%%
	\stepcounter{quests}
	\setcounter{subquests}{0}
	\setcounter{subsubquests}{0}
	\setcounter{figs}{0}
	\ifempty{#1}{%%
		\def\thisquest{\unskip}%
	}{%%
		\def\thisquest{.: {\normalfont#1}}%
	}
    \par\addvspace{2ex}{\bfseries{\translate[to=\userlang]{Question} \thequests}\thisquest\par\addvspace{1ex}}%%
}

\newcommand{\subquest}[1]{%%
	\stepcounter{subquests}
	\setcounter{subsubquests}{0}
	\ifempty{#1}{%%
		\def\thissubquest{\space}%
	}{%%
		\def\thissubquest{.: {\normalfont#1}\par}%
	}
    \par\addvspace{1ex}{\large\bfseries\thesubquests\thissubquest}%%
}

\newcommand{\subsubquest}[1][\empty]{%%
	\stepcounter{subsubquests}
	\ifx#1\empty
		\def\thissubsubquest{\thesubsubquests}%
	\else
		\def\thissubsubquest{{#1}\hspace{3pt}}%
	\fi
	\par\addvspace{1ex}{\bfseries\thissubsubquest\hspace*{-3pt})}
}

%% ----------------------------------------------------------------------------- 
%% -----------------------------------------------------------------------------
%% -----------------------------------------------------------------------------
%% -----------------------------------------------------------------------------

\allowdisplaybreaks

%% Colors
\definecolor{codecolor}{rgb}{0.0, 0.0, 0.6}
\definecolor{stringcolor}{rgb}{0.0, 0.6, 0.0}
\definecolor{emphcolor}{rgb}{0.6, 0.0, 0.6}
\definecolor{commentcolor}{rgb}{0.6, 0.6, 0.6}

\newcommand{\keywordstyle}{%%
	\itshape\bfseries\color{codecolor}
}

\newcommand{\emphstyle}{%%
	\itshape\bfseries\color{emphcolor}
}

\newcommand{\stringstyle}{%%
	\color{stringcolor}
}

\newcommand{\commentstyle}{%%
	\itshape\bfseries\color{commentcolor}
}

\newcommand{\code}[1]{%%
	{\ttfamily\color{codecolor}\bfseries #1}%%
}

\newcommand{\type}[1]{%%
	{\emphstyle #1}%%
}

\DeclareRobustCommand{\rchi}{{\mathpalette\irchi\relax}}
\newcommand{\irchi}[2]{\raisebox{\depth}{$#1\chi$}} % inner command, used by \rchi

\DeclareRobustCommand{\rsqrt}{{\mathpalette\irsqrt\relax}}
\newcommand{\irsqrt}[2]{\raisebox{\depth}{$#1\sqrt{}$}} % inner command, used by \rchi


%% ---------------------------- Listings ---------------------------
\def\addlstliterate#1{\edef\lst@literate{\unexpanded\expandafter{\lst@literate}\unexpanded{#1}}}
\lst@Key{moreliterate}{}{\addlstliterate{#1}}

\lstdefinestyle{literalstyle}{ %%
	mathescape=true,
	extendedchars=true,
	inputencoding=utf8,
	literate=
		{ã}{{\~a}}1                         {õ}{{\~o}}1 
		{Ã}{{\~A}}1                         {Õ}{{\~O}}1 
		{á}{{\'a}}1 {é}{{\'e}}1 {í}{{\'i}}1 {ó}{{\'o}}1 {ú}{{\'u}}1
		{Á}{{\'A}}1 {É}{{\'E}}1 {Í}{{\'I}}1 {Ó}{{\'O}}1 {Ú}{{\'U}}1
		{à}{{\`a}}1 {è}{{\`e}}1 {ì}{{\`i}}1 {ò}{{\`o}}1 {ù}{{\`u}}1
		{À}{{\`A}}1 {È}{{\'E}}1 {Ì}{{\`I}}1 {Ò}{{\`O}}1 {Ù}{{\`U}}1
		{ä}{{\"a}}1 {ë}{{\"e}}1 {ï}{{\"i}}1 {ö}{{\"o}}1 {ü}{{\"u}}1
		{Ä}{{\"A}}1 {Ë}{{\"E}}1 {Ï}{{\"I}}1 {Ö}{{\"O}}1 {Ü}{{\"U}}1
		{â}{{\^a}}1 {ê}{{\^e}}1 {î}{{\^i}}1 {ô}{{\^o}}1 {û}{{\^u}}1
		{Â}{{\^A}}1 {Ê}{{\^E}}1 {Î}{{\^I}}1 {Ô}{{\^O}}1 {Û}{{\^U}}1
		{œ}{{\oe}}1 {Œ}{{\OE}}1 {æ}{{\ae}}1 {Æ}{{\AE}}1 {ß}{{\ss}}1
		{ç}{{\c c}}1 {Ç}{{\c C}}1 {ø}{{\o}}1 {å}{{\r a}}1 {Å}{{\r A}}1
		{€}{{\EUR}}1 {£}{{\pounds}}1
		{~}{{{\raisebox{0.5ex}{\texttildelow}}}}1
		{^}{{{\raisebox{-0.5ex}{\textasciicircum}}}}1
		{√}{{{\raisebox{0.5ex}{$\sqrt{}$}}}}1
		{≈}{{$\approx$}}1
		{∫}{{$\int$}}1 {∞}{{$\infty$}}1
		{α}{{$\alpha$}}1 {β}{{$\beta$}}1  {γ}{{$\gamma$}}1 {ε}{{$\epsilon$}}1
		{ω}{{$\omega$}}1 {σ}{{$\sigma$}}1 {δ}{{$\delta$}}1 {Δ}{{$\Delta$}}1
		{π}{{$\pi$}}1    {θ}{{$\theta$}}1 {η}{{$\eta$}}1   {ξ}{{$\xi$}}1	
		{¹}{{$^1$}}1     {²}{{$^2$}}1     {³}{{$^3$}}1     {⁴}{{$^4$}}1     {⁵}{{$^5$}}1
}

\lstdefinestyle{basestyle}{ %%
	style=literalstyle,
	basicstyle=\ttfamily,
	numberblanklines=true,
	showstringspaces=false,
	breakatwhitespace=false,
	breaklines=true,
	stepnumber=1,
	numbers=left,
	frame=single,
	tabsize=4,
	gobble=4,
	emphstyle={\emphstyle},
	stringstyle={\stringstyle},
	keywordstyle={\keywordstyle},
	commentstyle={\commentstyle},
}


%% ----------------------------------- Algor -----------------------------------
%%
\newcounter{algors}
\setcounter{algors}{0}

\lstdefinestyle{algorstyle} { %%
	style=basestyle,
	morekeywords={%  
		def, lambda, seja, sejam, enquanto, para, de, cada, em, se, retorna, continua, e, ou%
	},
	morecomment=[l]{//},
	morecomment=[s]{/*}{*/},
	morestring=[b]",
	moreliterate=
	{<-}{{{$\leftarrow$}}}1
	{->}{{{$\rightarrow$}}}1
	{<->}{{{$\longleftrightarrow$}}}1
	%%
	{até}{{{\keywordstyle at{\'e}}}}3
	{senão}{{{\keywordstyle sen{\~a}o}}}5
	%%
	{\_\_}{{{\_}}}1
	,
	moredelim={[is][\emphstyle]{\_}{\_}}
}

\lstnewenvironment{algor}[1][\empty]{%%
	\ifx#1\empty
	\def\thistitle{\unskip}%
	\else
	\def\thistitle{.: #1}%
	\fi
	\stepcounter{algors}
	\lstset{style=algorstyle, title={Algoritmo \thealgors\thistitle}}
}{%%
}

%%
%% ----------------------------------- Algor -----------------------------------


%% ------------------------------------ Fortran ------------------------------------
%%
\lstdefinestyle{fortranstyle}{ %%
	style=basestyle,
	language={[95]Fortran},
	morekeywords={%  
		dabs, dsin, dcos, datan2%
	},
}

\lstnewenvironment{fortran}[1][\empty]{%%
	\ifx#1\empty
	\def\thistitle{\unskip}%
	\else
	\def\thistitle{.: #1}%
	\fi
	\stepcounter{algors}
	\lstset{style=fortranstyle, title={Algoritmo \thealgors\thistitle}}
	}{%%
}
%%
%% ------------------------------------ Fortran ------------------------------------

%% ---------------------- MAKETITLES ------------------------
\renewcommand{\maketitle}[1][\empty]{%%
	\maketitle*[#1]
	\pagebreak
}

\WithSuffix\newcommand\maketitle*[1][\empty]{%%
	\begin{center}
		{\huge\bfseries \@title\space} \par\addvspace{5pt}
		{\Large\bfseries \@subtitle\space} \par\addvspace{10pt}
		{\Large \@author\space} \par
		{\ttfamily\Large \@register\space} \par\addvspace{5pt}
		{\large \@date}\par
		\if\empty#1%%
			%%
		\else%%
			\vfill%%
			\begin{figure}[H]
				\centering
				\includegraphics{#1}
			\end{figure}
			\vfill%%
		\fi
	\end{center}
}


%% Centered maketitle
\newcommand{\cmaketitle}[1][\empty]{%%
	\ifx#1\empty
	\def\thiswallpaper{\empty}%
	\else
	\def\thiswallpaper{\wallpaper{#1}}%
	\fi
	\topskip0pt
	\vspace*{\fill}
	\begin{center}
		{\Huge\bfseries \@title\space} \\ \vspace{30pt}
		{\huge \@author} \\ \vspace{5pt}
		{\ttfamily\Large \@register\space} \\ \vspace{20pt}
		{\Large \@date \space}
	\end{center}
	\vspace*{\fill}
	\thiswallpaper
	\pagebreak
}

%% Simple maketitle
\newcommand{\smaketitle}{%%
	\begin{center}
		{\Large \bfseries \@title\space} \\
		{\Large \@author} \\
		{\ttfamily\Large \@register\space} \\ 
		{\@date}
	\end{center}
}

%% Aliased figure environment
\newenvironment{fig}[1][\empty]{%% in-code
	\ifx#1\empty
		\def\thiscaption{\unskip}%
	\else
		\def\thiscaption{\caption{#1}}%
	\fi
	\shorthandoff{"}
	\begin{figure}[H]
		\centering
	}{%% out-code
		\thiscaption
		\stepcounter{figs}
		\label{fig:\thequests.\thefigs}
	\end{figure}
	\shorthandon{"}
}

%% -----------------------------------------------------------
%% -----------------------------------------------------------
%% -----------------------------------------------------------

%% Environment
\NewEnviron{answer}%%
    {	%% PUSH
		\ifthenelse{\boolean{hideanswers}}{%%
			%% DO NOTHING
		}{%%
			\normalfont
			\begin{center}
				\begin{tcolorbox}[
					width=\textwidth,
					breakable,
					colback=\bgcolor,
					colframe=\fgcolor!50!gray,
					coltext=\fgcolor,
					]
					\textbf{Resposta}\break%%
					\BODY
				\end{tcolorbox}
			\end{center}
		}
    }{%%
		%% POP
    }

%% Theorem
\newtheorem*{theorem}{Teorema}
\newtheorem*{supposition}{Suposição}

%% EOI
\endinput
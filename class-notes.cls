\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{class-notes}[]

% --- Class Options Handling ---
% Passes any document options (like 11pt, oneside, etc.) straight to the book class
\DeclareOption*{%
	\PassOptionsToClass{\CurrentOption}{book}%
}
\ProcessOptions\relax

% --- Base Class ---
\LoadClass{book}

% --- Page Geometry ---
\RequirePackage{geometry}
\geometry{
	a4paper,
	outer=2.7in,
	inner=0.75in,
	top=0.85in,
	bottom=0.85in,
	marginparwidth=2in,
	marginparsep=0.3in
}

% --- Typography & Fonts ---
\RequirePackage[T1]{fontenc}
\RequirePackage{mathpazo}   % Palatino for body text and math
\RequirePackage{biolinum}   % Biolinum for sans-serif text

\usepackage[immediate]{silence}
\WarningFilter[temp]{latex}{Command} % silence the warning
\usepackage{sectsty}
\DeactivateWarningFilters[temp] % So nothing unrelated gets silenced

\makeatletter % disable the runtime redefinitions
\let\SS@makeulinesect\relax
\let\SS@makeulinepartchap\relax
\makeatother
\allsectionsfont{\sffamily}

% --- General Typesetting ---
\RequirePackage{enumitem}
\setlist[itemize,enumerate]{noitemsep, topsep=0pt}
\RequirePackage{array}
\renewcommand{\arraystretch}{1.5} 
\RequirePackage{microtype}

% --- Sidenotes & Margins ---
\RequirePackage{sidenotes}

% --- Colors ---
\RequirePackage{xcolor}
\definecolor{mathPurple}{HTML}{7F22A7} % Bright, true purple
\definecolor{mathGreen}{HTML}{108A64}  % Balanced secondary green
\definecolor{bgPurple}{HTML}{F9F0FC}   % Ultra-light purple fill
\definecolor{bgGreen}{HTML}{EFF8F5}    % Ultra-light green fill
\definecolor{textDark}{HTML}{242528}   % Off-black for crisp text

% --- Captions Configuration ---
\RequirePackage{caption}
\captionsetup[figure]{labelfont={sf,bf}, textfont=rm}
\DeclareCaptionStyle{marginfigure}{font=footnotesize, labelfont={sf,bf}, labelsep=space}
\DeclareCaptionStyle{sidecaption}{labelfont={sf,bf}, labelsep=space}
\DeclareCaptionStyle{widefigure}{labelfont={sf,bf}, labelsep=space}

% --- Figure Numbering ---
\RequirePackage{chngcntr}
\counterwithin{figure}{chapter}
\renewcommand{\thefigure}{\arabic{figure}}

% --- Math Environments & Theorems ---
\RequirePackage{amsmath, amssymb, amsthm, mathtools}
\RequirePackage{etoolbox}
\RequirePackage{mdframed}

\newtheoremstyle{sans-def}
{\topsep}{\topsep}{\rmfamily}{}{\bfseries\sffamily}{}{.5em}{}
\theoremstyle{sans-def}

\mdfdefinestyle{defnbg}{
	backgroundcolor=bgPurple, 
	linewidth=0pt, 
	innertopmargin=1pt, % Slightly increased so text doesn't hug the ceiling
	innerbottommargin=8pt
}
\mdfdefinestyle{thmbg}{
	backgroundcolor=bgGreen, 
	linewidth=0pt, 
	innertopmargin=1pt, % Slightly increased so text doesn't hug the ceiling
	innerbottommargin=8pt
}

\newtheorem{defn}{Definition}[chapter]
\surroundwithmdframed[style=defnbg]{defn}

\newtheorem{exmp}{Example}[chapter]

\newtheorem{thm}{Theorem}[chapter]
\surroundwithmdframed[style=thmbg]{thm}

\newenvironment{soln}
{\renewcommand{\qedsymbol}{$\blacksquare$}%
	\begin{proof}[Solution]}
	{\end{proof}}


% --- TikZ Graphics Setup ---
\RequirePackage{tikz}
\usetikzlibrary{external}
\tikzexternalize[prefix=figs/]
\RequirePackage{pgfplots}
\pgfplotsset{compat=1.18}

\newcommand{\boxmarker}{\textcolor{mathGreen}{$\blacksquare$}\hspace{0.5em}}
\newcommand{\bmarginnote}[1]{\marginpar{\footnotesize\boxmarker\color{textDark} #1}}

\AddToHook{begindocument/before}{
	\RequirePackage[bookmarks=true, hidelinks]{hyperref}
}
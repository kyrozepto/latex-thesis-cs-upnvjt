% template-2.cls -- UPN Veteran Jawa Timur Skripsi Template (2026)
% Updated to support the official cover layout with yellow rule and UPN logo
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{template}[2026/01/01 UPN Veteran Jatim Skripsi Template v2]
\LoadClass[12pt,a4paper,oneside]{report}

% ── Engine-aware font (XeLaTeX/LuaLaTeX gives the closest Times New Roman match)
\RequirePackage{iftex}
\ifPDFTeX
  \RequirePackage[T1]{fontenc}
  \RequirePackage[utf8]{inputenc}
  \RequirePackage{newtxtext,newtxmath}
\else
  \RequirePackage{fontspec}
  \IfFontExistsTF{Times New Roman}%
    {\setmainfont{Times New Roman}}%
    {\setmainfont{TeX Gyre Termes}}
\fi

% ── Page geometry (A4, top/bottom/right=2.5 cm, left=4.0 cm)
\RequirePackage[%
  a4paper,
  top    = 2.5cm,
  bottom = 2.5cm,
  left   = 4.0cm,
  right  = 2.5cm,
  bindingoffset = 0pt,
  headheight    = 14pt,
  headsep       = 12pt,
  footskip      = 1.27cm
]{geometry}

% Cover/front-matter geometry (top/bottom/right=3.0 cm, left=4.0 cm)
\newcommand{\frontmattergeometry}{%
  \newgeometry{top=3cm,bottom=3cm,left=4cm,right=3cm,%
               headheight=14pt,headsep=12pt,footskip=1.25cm}}
\newcommand{\mainmattergeometry}{\restoregeometry}

% ── Colour (UPN cover yellow rule)
\RequirePackage{xcolor}
\definecolor{coverYellow}{RGB}{255,255,0}

\usepackage[pages=some]{background}
\backgroundsetup{
    scale=0.45,          % Mengatur ukuran logo (0.55 = 55% dari ukuran asli)
    opacity=0.05,        % Mengatur opasitas rendah (0.1 = sangat transparan / samar)
    angle=0,             % Posisi tegak (tidak berputar)
    contents={\includegraphics{logo_upn.png}}, % File gambar logo Anda
    vshift=1cm,          % Pergeseran vertikal ke tengah (atur jika kurang pas)
    hshift=1cm           % Pergeseran horizontal ke tengah
}

% ── Spacing & justification
\RequirePackage{setspace}
\usepackage{microtype}
\hyphenpenalty=10000
\emergencystretch=\maxdimen
\onehalfspacing
\RequirePackage{ragged2e}
\RequirePackage{indentfirst}
\AtBeginDocument{\justifying}

% ── Paragraph model: Indented first line
\setlength{\parindent}{1.25cm}
\setlength{\parskip}{0pt}

% ── Heading numbering & format
\RequirePackage{titlesec}
\renewcommand{\thechapter}{\Roman{chapter}}
\renewcommand{\thesection}{\arabic{chapter}.\arabic{section}.}
\renewcommand{\thesubsection}{\thesection\arabic{subsection}.}
\renewcommand{\thesubsubsection}{\thesubsection\arabic{subsubsection}.}

\titleformat{\chapter}[display]
  {\normalfont\normalsize\bfseries\centering}
  {BAB \thechapter}
  % {CHAPTER \thechapter}
  {0pt}
  {\MakeUppercase}
\titlespacing*{\chapter}{0pt}{0pt}{12pt}

\titleformat{\section}[hang]
  {\normalfont\normalsize\bfseries}{\thesection}{0.5em}{}
\titlespacing*{\section}{0pt}{12pt}{0pt}

\titleformat{\subsection}[hang]
  {\normalfont\normalsize\bfseries}{\thesubsection}{0.5em}{}
\titlespacing*{\subsection}{0pt}{12pt}{0pt}

\titleformat{\subsubsection}[hang]
  {\normalfont\normalsize\bfseries}{\thesubsubsection}{0.5em}{}
\titlespacing*{\subsubsection}{0pt}{12pt}{0pt}

% ── Lists (compact, Word-like)
\RequirePackage{enumitem}
\setlist{nosep,topsep=0pt,partopsep=0pt,parsep=0pt,itemsep=0pt,%
         leftmargin=1.25cm,labelsep=0.35cm}
\setlist[enumerate,1]{label=\arabic*.,leftmargin=1.25cm}
\setlist[itemize,1]{label=\textbullet,leftmargin=1.25cm}

% ── Tables
\RequirePackage{array,booktabs,tabularx,longtable,multirow,makecell}
\setlength{\tabcolsep}{5.75pt}
\renewcommand{\arraystretch}{1.15}

% ── Captions (small bold, centred, period separator)
\RequirePackage{caption}
\captionsetup{%
  font            = small,
  labelfont       = bf,
  textfont        = bf,
  justification   = centering,
  singlelinecheck = false,
  skip            = 6pt,
  labelsep        = period
}

% ── Rename standard nomenclature
\AtBeginDocument{%
  % \renewcommand{\figurename}{Figure}
  % \renewcommand{\tablename}{Table}
  % \renewcommand{\contentsname}{TABLE OF CONTENTS}
  % \renewcommand{\listfigurename}{LIST OF FIGURES}
  % \renewcommand{\listtablename}{LIST OF TABLES}
  % \renewcommand{\bibname}{BIBLIOGRAPHY}
  \renewcommand{\figurename}{Gambar}
  \renewcommand{\tablename}{Tabel}
  \renewcommand{\contentsname}{DAFTAR ISI}
  \renewcommand{\listfigurename}{DAFTAR GAMBAR}
  \renewcommand{\listtablename}{DAFTAR TABEL}
  \renewcommand{\bibname}{DAFTAR PUSTAKA}
}

% ── Graphics
\RequirePackage{graphicx}

% ── Header / footer: centred page number, no rules
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}
\cfoot{\thepage}
\fancypagestyle{plain}{%
  \fancyhf{}%
  \renewcommand{\headrulewidth}{0pt}%
  \renewcommand{\footrulewidth}{0pt}%
  \cfoot{\thepage}%
}

% ── TOC / section depth
\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{3}


% ── Menambahkan Titik-titik (Dotted Leaders) pada Semua Daftar
\RequirePackage{tocloft}
\renewcommand{\cftchapleader}{\cftdotfill{4}} % Mengunci jarak titik bab jadi 4
\renewcommand{\cftfigleader}{\cftdotfill{4}}  % Mengunci jarak titik gambar jadi 4
\renewcommand{\cfttableader}{\cftdotfill{4}}  % Mengunci jarak titik tabel jadi 4
% ── Pusatkan judul Daftar Isi, Daftar Gambar, Daftar Tabel
\renewcommand{\cfttoctitlefont}{\hfill\normalfont\normalsize\bfseries}
\renewcommand{\cftaftertoctitle}{\hfill}
\setlength{\cftbeforetoctitleskip}{0pt}
\setlength{\cftaftertoctitleskip}{12pt}

\renewcommand{\cftloftitlefont}{\hfill\normalfont\normalsize\bfseries}
\renewcommand{\cftafterloftitle}{\hfill}
\setlength{\cftbeforeloftitleskip}{0pt}
\setlength{\cftafterloftitleskip}{12pt}

\renewcommand{\cftlottitlefont}{\hfill\normalfont\normalsize\bfseries}
\renewcommand{\cftafterlottitle}{\hfill}
\setlength{\cftbeforelottitleskip}{0pt}
\setlength{\cftafterlottitleskip}{12pt}

% ── Jarak antar entri Daftar Isi
\setlength{\cftbeforechapskip}{6pt}      % jarak sebelum entri bab
\setlength{\cftbeforesecskip}{3pt}       % jarak sebelum entri subbab
\setlength{\cftbeforesubsecskip}{0pt}    % jarak sebelum entri subsubbab
\setlength{\cftbeforesubsubsecskip}{0pt} % jarak sebelum entri level 4
% ── Helper: intentionally blank page
\newcommand{\halamanKosong}{%
  \clearpage
  \thispagestyle{empty}%
  \vspace*{\fill}%
  \begin{center}
    % \textit{This page is intentionally left blank}
    \textit{Halaman ini sengaja dikosongkan}
  \end{center}%
  \vspace*{\fill}%
  \clearpage
}
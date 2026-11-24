% template.cls -- UPN Veteran Jawa Timur Thesis Template (2026)
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{template}[2026/11/24 UPN Veteran Jatim Skripsi Template v4]

% ── Class options
%   \documentclass{template}          -> screen edition, one-sided (default)
%   \documentclass[print]{template}   -> two-sided print edition: chapters open
%                                        on a right-hand page, inner/outer margins
%                                        swap per page, and every filler page
%                                        carries "Halaman ini sengaja dikosongkan".
% `twoside` is accepted as a synonym of `print`.
\newif\if@printmode\@printmodefalse
\DeclareOption{print}{\@printmodetrue}
\DeclareOption{twoside}{\@printmodetrue}
\DeclareOption{oneside}{\@printmodefalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax

\if@printmode
  \LoadClass[12pt,a4paper,twoside,openright]{report}
\else
  \LoadClass[12pt,a4paper,oneside]{report}
\fi

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
% The print edition uses inner/outer instead of left/right, so the 4 cm binding
% margin is always on the spine side of the sheet.
\if@printmode
  \RequirePackage[%
    a4paper,
    top    = 2.5cm,
    bottom = 2.5cm,
    inner  = 4.0cm,
    outer  = 2.5cm,
    bindingoffset = 0pt,
    headheight    = 14pt,
    headsep       = 12pt,
    footskip      = 1.27cm
  ]{geometry}
  % Cover/front-matter geometry (top/bottom/outer=3.0 cm, inner=4.0 cm)
  \newcommand{\frontmattergeometry}{%
    \newgeometry{top=3cm,bottom=3cm,inner=4cm,outer=3cm,%
                 headheight=14pt,headsep=12pt,footskip=1.25cm}}
  % Pages left empty by \cleardoublepage get no page number.
  \RequirePackage{emptypage}
\else
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
\fi
\newcommand{\mainmattergeometry}{\restoregeometry}

% ── Colour (UPN cover yellow rule, orange outer cover)
\RequirePackage{xcolor}
\definecolor{coverYellow}{RGB}{255,255,0}
\definecolor{coverOrange}{RGB}{255,145,77}

% Faint UPN logo behind LEMBAR PENGESAHAN and LEMBAR PERSETUJUAN (\BgThispage).
% Values match the 2026 faculty sample book: the logo spans about 74% of the
% page width, centred vertically and nudged slightly right.
\RequirePackage[pages=some]{background}
\backgroundsetup{
    scale=0.54,
    opacity=0.08,
    angle=0,
    contents={\includegraphics{logo_upn.png}},
    vshift=0cm,
    hshift=0.6cm
}

% ── Spacing & justification
\RequirePackage{setspace}
\RequirePackage{microtype}
\hyphenpenalty=10000
\emergencystretch=\maxdimen
% Front matter and every list use 1.5 spacing. From Bab I onward the body uses
% \ThesisBodySpacing (1.33, about 19.3 pt at 12 pt), which matches the line
% density of the faculty sample book. The abstract and preface use it as well.
\onehalfspacing
\newcommand{\ThesisBodySpacing}{\setstretch{1.33}}
\RequirePackage{ragged2e}
\RequirePackage{indentfirst}
% report switches on \flushbottom in two-sided mode, which stretches the space
% between [H] floats to fill the page. \raggedbottom keeps the natural spacing
% and leaves the remainder at the foot of the page, in both editions.
\AtBeginDocument{\justifying\raggedbottom}

% ── Paragraph model: Indented first line
\setlength{\parindent}{1.25cm}
\setlength{\parskip}{0pt}

% ── Heading numbering & format
\RequirePackage{titlesec}
\renewcommand{\thechapter}{\Roman{chapter}}
\renewcommand{\thesection}{\arabic{chapter}.\arabic{section}.}
\renewcommand{\thesubsection}{\thesection\arabic{subsection}.}
\renewcommand{\thesubsubsection}{\thesubsection\arabic{subsubsection}.}
\renewcommand{\theequation}{\arabic{chapter}.\arabic{equation}}
\renewcommand{\thefigure}{\arabic{chapter}. \arabic{figure}}
\renewcommand{\thetable}{\arabic{chapter}. \arabic{table}}

% Chapter heading. \ChapterPrefix comes from config/thesis-language.tex, which is
% loaded after this class; the fallback below keeps the class usable on its own.
% config/thesis-language.tex also provides \ApplyMainChapterStyle, which reissues
% this format after the front matter has temporarily switched it off.
\providecommand{\ChapterPrefix}{BAB}
\titleformat{\chapter}[display]
  {\normalfont\normalsize\bfseries\centering}
  {\ChapterPrefix\ \thechapter}
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

% ── Standard nomenclature (Gambar/Tabel/DAFTAR ISI/...) is set by
% config/thesis-language.tex so that it follows \ThesisLanguage. Nothing is
% hardcoded here: two competing \AtBeginDocument hooks would make the language
% switch depend on load order.

% ── Graphics
\RequirePackage{graphicx}
% Vector QR code on PERNYATAAN ORISINALITAS (\OriginalityQRLink).
\RequirePackage{qrcode}
% Thin black frame for screenshots and scanned documents. \linewidth is reduced
% by both rule widths so a full-width image does not overflow the text block.
%   \BorderedGraphics[width=\linewidth]{screenshot.png}
\newcommand{\BorderedGraphics}[2][]{{\setlength{\fboxsep}{0pt}\setlength{\fboxrule}{0.6pt}\addtolength{\linewidth}{-1.2pt}\fbox{\includegraphics[#1]{#2}}}}

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
\newcommand{\ThesisDotSep}{0.8}
\renewcommand{\cftchapleader}{\cftdotfill{\ThesisDotSep}}
\renewcommand{\cftfigleader}{\cftdotfill{\ThesisDotSep}}
\renewcommand{\cfttableader}{\cftdotfill{\ThesisDotSep}}
\renewcommand{\cftfigpresnum}{\figurename\ }
\renewcommand{\cftfigaftersnum}{\ }
\renewcommand{\cfttabpresnum}{\tablename\ }
\renewcommand{\cfttabaftersnum}{\ }
\setlength{\cftfignumwidth}{5.8em}
\setlength{\cfttabnumwidth}{5.2em}

% ── Daftar Lampiran
% Daftar lampiran memakai berkas bantu .lap, bukan .loa, karena algorithm2e
% sudah memakai .loa untuk Daftar Algoritma. Berbagi satu berkas membuat kedua
% daftar tercetak dengan isi yang tercampur.
\makeatletter
\newcommand{\listofappendices}{%
  \chapter*{\AppendixListLabel}%
  \@starttoc{lap}%
}
\newcommand*{\l@appendixsection}{\@dottedtocline{1}{0pt}{2.8em}}
\newcommand*{\l@appendixsubsection}{\@dottedtocline{2}{1.5em}{3.8em}}
% Setiap lampiran dimulai pada halaman baru: masing-masing merupakan unit yang
% dirujuk sendiri-sendiri dari bab utama dan dicari lewat Daftar Lampiran, sehingga
% judul yang terbenam di tengah halaman membuat batas antarlampiran kabur. Lampiran
% pertama dikecualikan agar paragraf pengantar bab tidak tertinggal sendirian.
\newif\if@firstappendixsection
\@firstappendixsectiontrue
% \def\@currentlabelname diperlukan agar \nameref pada \label yang mengikuti
% kedua perintah ini mengembalikan judulnya. Tanpa itu hyperref membiarkan nama
% tersebut kosong, sebab \section*/\subsection* tidak menetapkannya sendiri dan
% jenis contentsline "lap" bukan jenis baku yang ditambal hyperref.
\newcommand{\AppendixSection}[1]{%
  \if@firstappendixsection\@firstappendixsectionfalse\else\clearpage\fi
  \phantomsection
  \section*{#1}%
  \addcontentsline{lap}{appendixsection}{#1}%
  \def\@currentlabelname{#1}%
}
\newcommand{\AppendixSubsection}[1]{%
  \phantomsection
  \subsection*{#1}%
  \addcontentsline{lap}{appendixsubsection}{#1}%
  \def\@currentlabelname{#1}%
}
\makeatother

% ── Integrasi algorithm2e
% Dibungkus \@ifpackageloaded agar berkas kelas ini tetap aman dimuat dokumen
% yang tidak memuat algorithm2e, misalnya naskah proposal.
\makeatletter
\newcommand{\Thesis@algotweaks}{%
  \@addtoreset{algocf}{chapter}%
  \renewcommand{\thealgocf}{\arabic{chapter}. \arabic{algocf}}%
  \renewcommand{\@dotsep}{\ThesisDotSep}%
  % Indentasi 1.5em menyamakan tepi kiri Daftar Algoritma dengan Daftar Gambar
  % dan Daftar Tabel (nilai bawaan \cftfigindent/\cfttabindent milik tocloft).
  \renewcommand*{\l@algocf}{\@dottedtocline{1}{1.5em}{7.1em}}%
  % Komentar pseudocode memakai font naskah, bukan mesin tik bawaan algorithm2e.
  \SetCommentSty{textnormal}%
}
\@ifpackageloaded{algorithm2e}{%
  \Thesis@algotweaks
}{%
  \AtBeginDocument{%
    \@ifpackageloaded{algorithm2e}{\Thesis@algotweaks}{}%
  }%
}
\makeatother
% Algoritma [H] diberi jarak atas/bawah yang sama dengan gambar dan tabel [H]
% (\intextsep); \addvspace mencegah jarak ganda setelah judul subbab. Hook ini
% tidak berpengaruh pada naskah yang tidak memuat algorithm2e.
\AddToHook{env/algorithm/before}{\par\addvspace{\intextsep}}
\AddToHook{env/algorithm/after}{\par\addvspace{\intextsep}}
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
    \textit{\Lang{Halaman ini sengaja dikosongkan}{This page is intentionally left blank}}
  \end{center}%
  \vspace*{\fill}%
  \clearpage
}

% ── Page breaks that follow the edition
% Use these in the front matter instead of \halamanKosong and \clearpage, so one
% source file serves both the screen and the print edition.
%
%   \ThesisBlankPage  screen: always inserts a "sengaja dikosongkan" page
%                     print:  moves to the next right-hand page; the filler page,
%                             if one is needed, carries the same note
%   \ThesisPageBreak  screen: \clearpage
%                     print:  \cleardoublepage
\makeatletter
\if@printmode
  % Every filler page inserted by \cleardoublepage, including the openright
  % break before each chapter, carries the blank-page note.
  \renewcommand{\cleardoublepage}{%
    \clearpage
    \if@twoside\ifodd\c@page\else\halamanKosong\fi\fi}
  \newcommand{\ThesisBlankPage}{\cleardoublepage}
  \newcommand{\ThesisPageBreak}{\cleardoublepage}
\else
  \newcommand{\ThesisBlankPage}{\halamanKosong}
  \newcommand{\ThesisPageBreak}{\clearpage}
\fi
\newif\ifThesisPrint
\if@printmode\ThesisPrinttrue\fi
\makeatother

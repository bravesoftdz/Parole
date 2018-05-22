unit Unit1; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Buttons;
  
type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ToggleBox1: TToggleBox;
    ToggleBox10: TToggleBox;
    ToggleBox11: TToggleBox;
    ToggleBox12: TToggleBox;
    ToggleBox13: TToggleBox;
    ToggleBox14: TToggleBox;
    ToggleBox15: TToggleBox;
    ToggleBox16: TToggleBox;
    ToggleBox17: TToggleBox;
    ToggleBox18: TToggleBox;
    ToggleBox19: TToggleBox;
    ToggleBox2: TToggleBox;
    ToggleBox20: TToggleBox;
    ToggleBox21: TToggleBox;
    ToggleBox22: TToggleBox;
    ToggleBox23: TToggleBox;
    ToggleBox24: TToggleBox;
    ToggleBox25: TToggleBox;
    ToggleBox26: TToggleBox;
    ToggleBox3: TToggleBox;
    ToggleBox4: TToggleBox;
    ToggleBox5: TToggleBox;
    ToggleBox6: TToggleBox;
    ToggleBox7: TToggleBox;
    ToggleBox8: TToggleBox;
    ToggleBox9: TToggleBox;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

    procedure savescore;
    procedure newword;
    procedure label2draw;
    procedure showcontrols(setme:boolean);

  private
    { private declarations }
  public
    { public declarations }
  end;

const letters:set of char = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
const maxwords=1000;
const maxletters=20;

var
  Form1: TForm1;
  nwords,currentword: integer;
  wrongletters:string;
  words: array[1..maxwords,1..2] of string;
  score: array[1..maxwords] of byte;
  file1: text;
  file2: file of byte;
  label2open: array[1..maxletters] of boolean;

implementation

{ TForm1 }

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
var ch1:char;
    i:integer;
    found:boolean;
begin
  ch1:=chr(lo(key));
  if ch1 in letters then begin
    found:=false;
    for i:=1 to length(words[currentword,1]) do
      if ch1=words[currentword,1][i] then begin
        found:=true;
        label2open[i]:=true;
      end;
    if found then begin
      found:=true;
      for i:=1 to length(words[currentword,1]) do
        if not label2open[i] then found:=false;
      if (found) and (button1.visible=false) then begin
        if score[currentword]<250 then inc(score[currentword]);
        showcontrols(false);
      end;
    end else begin
      found:=false;
      if length(wrongletters)>0 then
        for i:=1 to length(wrongletters) do if ch1=wrongletters[i] then found:=true;
      if found=false then begin
        wrongletters:=wrongletters+ch1;
        if score[currentword]>1 then dec(score[currentword]);
      end;
      case ch1 of
       'Q':togglebox1.checked:=true;
       'W':togglebox2.checked:=true;
       'E':togglebox3.checked:=true;
       'R':togglebox4.checked:=true;
       'T':togglebox5.checked:=true;
       'Y':togglebox6.checked:=true;
       'U':togglebox7.checked:=true;
       'I':togglebox8.checked:=true;
       'O':togglebox9.checked:=true;
       'P':togglebox10.checked:=true;
       'A':togglebox11.checked:=true;
       'S':togglebox12.checked:=true;
       'D':togglebox13.checked:=true;
       'F':togglebox14.checked:=true;
       'G':togglebox15.checked:=true;
       'H':togglebox16.checked:=true;
       'J':togglebox17.checked:=true;
       'K':togglebox18.checked:=true;
       'L':togglebox19.checked:=true;
       'Z':togglebox20.checked:=true;
       'X':togglebox21.checked:=true;
       'C':togglebox22.checked:=true;
       'V':togglebox23.checked:=true;
       'B':togglebox24.checked:=true;
       'N':togglebox25.checked:=true;
       'M':togglebox26.checked:=true;
      end;
      ShowMessage('Нет такой буквы!')
    end;
    
    label2draw;
  end;
  
  if (key=13) and (button1.visible) then newword;
end;

procedure Tform1.showcontrols(setme:boolean);
begin
  button1.enabled:=not setme;
  button1.visible:=not setme;
  
  togglebox1.visible:=setme;
  togglebox2.visible:=setme;
  togglebox3.visible:=setme;
  togglebox4.visible:=setme;
  togglebox5.visible:=setme;
  togglebox6.visible:=setme;
  togglebox7.visible:=setme;
  togglebox8.visible:=setme;
  togglebox9.visible:=setme;
  togglebox10.visible:=setme;
  togglebox11.visible:=setme;
  togglebox12.visible:=setme;
  togglebox13.visible:=setme;
  togglebox14.visible:=setme;
  togglebox15.visible:=setme;
  togglebox16.visible:=setme;
  togglebox17.visible:=setme;
  togglebox18.visible:=setme;
  togglebox19.visible:=setme;
  togglebox20.visible:=setme;
  togglebox21.visible:=setme;
  togglebox22.visible:=setme;
  togglebox23.visible:=setme;
  togglebox24.visible:=setme;
  togglebox25.visible:=setme;
  togglebox26.visible:=setme;

  togglebox1.checked:=false;
  togglebox2.checked:=false;
  togglebox3.checked:=false;
  togglebox4.checked:=false;
  togglebox5.checked:=false;
  togglebox6.checked:=false;
  togglebox7.checked:=false;
  togglebox8.checked:=false;
  togglebox9.checked:=false;
  togglebox10.checked:=false;
  togglebox11.checked:=false;
  togglebox12.checked:=false;
  togglebox13.checked:=false;
  togglebox14.checked:=false;
  togglebox15.checked:=false;
  togglebox16.checked:=false;
  togglebox17.checked:=false;
  togglebox18.checked:=false;
  togglebox19.checked:=false;
  togglebox20.checked:=false;
  togglebox21.checked:=false;
  togglebox22.checked:=false;
  togglebox23.checked:=false;
  togglebox24.checked:=false;
  togglebox25.checked:=false;
  togglebox26.checked:=false;

  {togglebox1.Enabled:=true;
  togglebox2.Enabled:=true;
  togglebox3.Enabled:=true;
  togglebox4.Enabled:=true;
  togglebox5.Enabled:=true;
  togglebox6.Enabled:=true;
  togglebox7.Enabled:=true;
  togglebox8.Enabled:=true;
  togglebox9.Enabled:=true;
  togglebox10.Enabled:=true;
  togglebox11.Enabled:=true;
  togglebox12.Enabled:=true;
  togglebox13.Enabled:=true;
  togglebox14.Enabled:=true;
  togglebox15.Enabled:=true;
  togglebox16.Enabled:=true;
  togglebox17.Enabled:=true;
  togglebox18.Enabled:=true;
  togglebox19.Enabled:=true;
  togglebox20.Enabled:=true;
  togglebox21.Enabled:=true;
  togglebox22.Enabled:=true;
  togglebox23.Enabled:=true;
  togglebox24.Enabled:=true;
  togglebox25.Enabled:=true;
  togglebox26.Enabled:=true;}
end;

procedure Tform1.label2draw;
var i:integer;
begin
  label3.caption:='Счёт слова = '+inttostr(score[currentword]);
  label2.caption:='';
  for i:=1 to length(words[currentword,1]) do
   if not label2open[i] then
     label2.caption:=label2.caption+'?'
   else begin
     label2.caption:=label2.caption+words[currentword,1][i];
     case words[currentword,1][i] of
      'Q':togglebox1.visible:=false;
      'W':togglebox2.visible:=false;
      'E':togglebox3.visible:=false;
      'R':togglebox4.visible:=false;
      'T':togglebox5.visible:=false;
      'Y':togglebox6.visible:=false;
      'U':togglebox7.visible:=false;
      'I':togglebox8.visible:=false;
      'O':togglebox9.visible:=false;
      'P':togglebox10.visible:=false;
      'A':togglebox11.visible:=false;
      'S':togglebox12.visible:=false;
      'D':togglebox13.visible:=false;
      'F':togglebox14.visible:=false;
      'G':togglebox15.visible:=false;
      'H':togglebox16.visible:=false;
      'J':togglebox17.visible:=false;
      'K':togglebox18.visible:=false;
      'L':togglebox19.visible:=false;
      'Z':togglebox20.visible:=false;
      'X':togglebox21.visible:=false;
      'C':togglebox22.visible:=false;
      'V':togglebox23.visible:=false;
      'B':togglebox24.visible:=false;
      'N':togglebox25.visible:=false;
      'M':togglebox26.visible:=false;
     end;
   end;
end;

procedure Tform1.newword;
var i,j:integer;
    flg:boolean;
    lastword:integer;
begin
  savescore;
  wrongletters:='';
  lastword:=currentword;
  showcontrols(true);
  repeat
    currentword:=round(random*(nwords-1))+1;
    flg:=false;
    if (score[currentword]<=3) or (random<1/(score[currentword]+1)) then flg:=true;
    if (score[currentword]=0) and (random>0.1) then flg:=false;
  until (flg) and (currentword<>lastword);
  label1.caption:=words[currentword,2];
  flg:=false;
  repeat
    for i:=1 to length(words[currentword,1]) do
      if (random<1/(score[currentword]+5)) and (score[currentword]<10) then label2open[i]:=true else label2open[i]:=false;
    if score[currentword]<6 then begin
      label2open[1]:=true;
      if (score[currentword]<4) and ((length(words[currentword,1])>3) or (random<0.5)) then begin
        j:=1;
        for i:=2 to length(words[currentword,1]) do if label2open[i] then inc(j);
        if (length(words[currentword,1])-j>2) or (random<0.5) then label2open[2]:=true;
      end;
    end;

    for i:=1 to length(words[currentword,1])-1 do
      for j:=i+1 to length(words[currentword,1]) do if words[currentword,1][i]=words[currentword,1][j] then begin
        label2open[i]:=label2open[i] or label2open[j];
        label2open[j]:=label2open[i] or label2open[j];
      end;
    for i:=1 to length(words[currentword,1]) do if label2open[i]=false then flg:=true;
  until flg;

  label2draw;
end;

procedure Tform1.SaveScore;
var i:integer;
begin
  AssignFile(file2,'parole.sco');
  rewrite(file2);
  for i:=1 to nwords do write(file2,score[i]);
  closeFile(file2);
end;

procedure TForm1.FormCreate(Sender: TObject);
var nscore:integer;
begin
  AssignFile(file1,'parole.txt');
  reset(file1);
  nwords:=0;
  repeat
    inc(nwords);
    readln(file1,words[nwords,1]);
    readln(file1,words[nwords,2]);
    score[nwords]:=0;
  until eof(file1);
  closeFile(file1);

  AssignFile(file2,'parole.sco');
  {$i-}
  reset(file2);
  {$i+}
  if ioresult<>0 then rewrite(file2);
  for nscore:=1 to nwords do if not eof(file2) then read(file2,score[nscore]) else score[nscore]:=0;
  closeFile(file2);
  
  randomize;
  newword;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  newword
end;


initialization
  {$I unit1.lrs}

end.


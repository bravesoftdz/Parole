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
    procedure FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);

    procedure savescore;
    procedure newword;
    procedure label2draw;
    procedure showcontrols(setme: boolean);

  private
    { private declarations }
  public
    { public declarations }
  end;

const
  letters: set of char = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I',
    'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];

const
  maxwords = 1000;

const
  maxletters = 20;

var
  Form1: TForm1;
  nwords, currentword: integer;
  wrongletters: string;
  words: array[1..maxwords, 1..2] of string;
  score: array[1..maxwords] of byte;
  file1: Text;
  file2: file of byte;
  label2open: array[1..maxletters] of boolean;

implementation

{ TForm1 }

procedure TForm1.FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
var
  ch1: char;
  i: integer;
  found: boolean;
begin
  ch1 := chr(lo(key));
  if ch1 in letters then
  begin
    found := False;
    for i := 1 to length(words[currentword, 1]) do
      if ch1 = words[currentword, 1][i] then
      begin
        found := True;
        label2open[i] := True;
      end;
    if found then
    begin
      found := True;
      for i := 1 to length(words[currentword, 1]) do
        if not label2open[i] then
          found := False;
      if (found) and (button1.Visible = False) then
      begin
        if score[currentword] < 250 then
          Inc(score[currentword]);
        showcontrols(False);
      end;
    end
    else
    begin
      found := False;
      if length(wrongletters) > 0 then
        for i := 1 to length(wrongletters) do
          if ch1 = wrongletters[i] then
            found := True;
      if found = False then
      begin
        wrongletters := wrongletters + ch1;
        if score[currentword] > 1 then
          Dec(score[currentword]);
      end;
      case ch1 of
        'Q': togglebox1.Checked := True;
        'W': togglebox2.Checked := True;
        'E': togglebox3.Checked := True;
        'R': togglebox4.Checked := True;
        'T': togglebox5.Checked := True;
        'Y': togglebox6.Checked := True;
        'U': togglebox7.Checked := True;
        'I': togglebox8.Checked := True;
        'O': togglebox9.Checked := True;
        'P': togglebox10.Checked := True;
        'A': togglebox11.Checked := True;
        'S': togglebox12.Checked := True;
        'D': togglebox13.Checked := True;
        'F': togglebox14.Checked := True;
        'G': togglebox15.Checked := True;
        'H': togglebox16.Checked := True;
        'J': togglebox17.Checked := True;
        'K': togglebox18.Checked := True;
        'L': togglebox19.Checked := True;
        'Z': togglebox20.Checked := True;
        'X': togglebox21.Checked := True;
        'C': togglebox22.Checked := True;
        'V': togglebox23.Checked := True;
        'B': togglebox24.Checked := True;
        'N': togglebox25.Checked := True;
        'M': togglebox26.Checked := True;
      end;
      ShowMessage('Нет такой буквы!');
    end;

    label2draw;
  end;

  if (key = 13) and (button1.Visible) then
    newword;
end;

procedure Tform1.showcontrols(setme: boolean);
begin
  button1.Enabled := not setme;
  button1.Visible := not setme;

  togglebox1.Visible := setme;
  togglebox2.Visible := setme;
  togglebox3.Visible := setme;
  togglebox4.Visible := setme;
  togglebox5.Visible := setme;
  togglebox6.Visible := setme;
  togglebox7.Visible := setme;
  togglebox8.Visible := setme;
  togglebox9.Visible := setme;
  togglebox10.Visible := setme;
  togglebox11.Visible := setme;
  togglebox12.Visible := setme;
  togglebox13.Visible := setme;
  togglebox14.Visible := setme;
  togglebox15.Visible := setme;
  togglebox16.Visible := setme;
  togglebox17.Visible := setme;
  togglebox18.Visible := setme;
  togglebox19.Visible := setme;
  togglebox20.Visible := setme;
  togglebox21.Visible := setme;
  togglebox22.Visible := setme;
  togglebox23.Visible := setme;
  togglebox24.Visible := setme;
  togglebox25.Visible := setme;
  togglebox26.Visible := setme;

  togglebox1.Checked := False;
  togglebox2.Checked := False;
  togglebox3.Checked := False;
  togglebox4.Checked := False;
  togglebox5.Checked := False;
  togglebox6.Checked := False;
  togglebox7.Checked := False;
  togglebox8.Checked := False;
  togglebox9.Checked := False;
  togglebox10.Checked := False;
  togglebox11.Checked := False;
  togglebox12.Checked := False;
  togglebox13.Checked := False;
  togglebox14.Checked := False;
  togglebox15.Checked := False;
  togglebox16.Checked := False;
  togglebox17.Checked := False;
  togglebox18.Checked := False;
  togglebox19.Checked := False;
  togglebox20.Checked := False;
  togglebox21.Checked := False;
  togglebox22.Checked := False;
  togglebox23.Checked := False;
  togglebox24.Checked := False;
  togglebox25.Checked := False;
  togglebox26.Checked := False;

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
var
  i: integer;
begin
  label3.Caption := 'Счёт слова = ' + IntToStr(score[currentword]);
  label2.Caption := '';
  for i := 1 to length(words[currentword, 1]) do
    if not label2open[i] then
      label2.Caption := label2.Caption + '?'
    else
    begin
      label2.Caption := label2.Caption + words[currentword, 1][i];
      case words[currentword, 1][i] of
        'Q': togglebox1.Visible := False;
        'W': togglebox2.Visible := False;
        'E': togglebox3.Visible := False;
        'R': togglebox4.Visible := False;
        'T': togglebox5.Visible := False;
        'Y': togglebox6.Visible := False;
        'U': togglebox7.Visible := False;
        'I': togglebox8.Visible := False;
        'O': togglebox9.Visible := False;
        'P': togglebox10.Visible := False;
        'A': togglebox11.Visible := False;
        'S': togglebox12.Visible := False;
        'D': togglebox13.Visible := False;
        'F': togglebox14.Visible := False;
        'G': togglebox15.Visible := False;
        'H': togglebox16.Visible := False;
        'J': togglebox17.Visible := False;
        'K': togglebox18.Visible := False;
        'L': togglebox19.Visible := False;
        'Z': togglebox20.Visible := False;
        'X': togglebox21.Visible := False;
        'C': togglebox22.Visible := False;
        'V': togglebox23.Visible := False;
        'B': togglebox24.Visible := False;
        'N': togglebox25.Visible := False;
        'M': togglebox26.Visible := False;
      end;
    end;
end;

procedure Tform1.newword;
var
  i, j: integer;
  flg: boolean;
  lastword: integer;
begin
  savescore;
  wrongletters := '';
  lastword := currentword;
  showcontrols(True);
  repeat
    currentword := round(random * (nwords - 1)) + 1;
    flg := False;
    if (score[currentword] <= 3) or (random < 1 / (score[currentword] + 1)) then
      flg := True;
    if (score[currentword] = 0) and (random > 0.1) then
      flg := False;
  until (flg) and (currentword <> lastword);
  label1.Caption := words[currentword, 2];
  flg := False;
  repeat
    for i := 1 to length(words[currentword, 1]) do
      if (random < 1 / (score[currentword] + 5)) and (score[currentword] < 10) then
        label2open[i] := True
      else
        label2open[i] := False;
    if score[currentword] < 6 then
    begin
      label2open[1] := True;
      if (score[currentword] < 4) and ((length(words[currentword, 1]) > 3) or
        (random < 0.5)) then
      begin
        j := 1;
        for i := 2 to length(words[currentword, 1]) do
          if label2open[i] then
            Inc(j);
        if (length(words[currentword, 1]) - j > 2) or (random < 0.5) then
          label2open[2] := True;
      end;
    end;

    for i := 1 to length(words[currentword, 1]) - 1 do
      for j := i + 1 to length(words[currentword, 1]) do
        if words[currentword, 1][i] = words[currentword, 1][j] then
        begin
          label2open[i] := label2open[i] or label2open[j];
          label2open[j] := label2open[i] or label2open[j];
        end;
    for i := 1 to length(words[currentword, 1]) do
      if label2open[i] = False then
        flg := True;
  until flg;

  label2draw;
end;

procedure Tform1.SaveScore;
var
  i: integer;
begin
  AssignFile(file2, 'parole.sco');
  rewrite(file2);
  for i := 1 to nwords do
    Write(file2, score[i]);
  closeFile(file2);
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  nscore: integer;
begin
  AssignFile(file1, 'parole.txt');
  reset(file1);
  nwords := 0;
  repeat
    Inc(nwords);
    readln(file1, words[nwords, 1]);
    readln(file1, words[nwords, 2]);
    score[nwords] := 0;
  until EOF(file1);
  closeFile(file1);

  AssignFile(file2, 'parole.sco');
  {$i-}
  reset(file2);
  {$i+}
  if ioresult <> 0 then
    rewrite(file2);
  for nscore := 1 to nwords do
    if not EOF(file2) then
      Read(file2, score[nscore])
    else
      score[nscore] := 0;
  closeFile(file2);

  randomize;
  newword;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  newword;
end;


initialization
  {$I unit1.lrs}

end.

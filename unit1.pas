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

    procedure SaveScore;
    procedure NewWord;
    procedure Label2Draw;
    procedure ShowControls(SetMe: boolean);

  private
    { private declarations }
  public
    { public declarations }
  end;

const
  Letters: set of char = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I',
    'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];

const
  MaxWords = 1000;

const
  MaxLetters = 20;

var
  Form1: TForm1;
  NWords, CurrentWord: integer;
  WrongLetters: string;
  Words: array[1..MaxWords, 1..2] of string;
  Score: array[1..MaxWords] of byte;
  File1: Text;
  File2: file of byte;
  Label2Open: array[1..MaxLetters] of boolean;

implementation

{ TForm1 }

procedure TForm1.FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
var
  ch1: char;
  i: integer;
  Found: boolean;
begin
  ch1 := chr(lo(key));
  if ch1 in Letters then
  begin
    Found := false;
    for i := 1 to Length(Words[CurrentWord, 1]) do
      if ch1 = Words[CurrentWord, 1][i] then
      begin
        Found := true;
        Label2Open[i] := true;
      end;
    if Found then
    begin
      Found := true;
      for i := 1 to Length(Words[CurrentWord, 1]) do
        if not Label2Open[i] then
          Found := false;
      if (Found) and (Button1.Visible = false) then
      begin
        if Score[CurrentWord] < 250 then
          Inc(Score[CurrentWord]);
        ShowControls(false);
      end;
    end
    else
    begin
      Found := false;
      if Length(WrongLetters) > 0 then
        for i := 1 to Length(WrongLetters) do
          if ch1 = WrongLetters[i] then
            Found := true;
      if Found = false then
      begin
        WrongLetters := WrongLetters + ch1;
        if Score[CurrentWord] > 1 then
          Dec(Score[CurrentWord]);
      end;
      case ch1 of
        'Q': ToggleBox1.Checked := true;
        'W': ToggleBox2.Checked := true;
        'E': ToggleBox3.Checked := true;
        'R': ToggleBox4.Checked := true;
        'T': ToggleBox5.Checked := true;
        'Y': ToggleBox6.Checked := true;
        'U': ToggleBox7.Checked := true;
        'I': ToggleBox8.Checked := true;
        'O': ToggleBox9.Checked := true;
        'P': ToggleBox10.Checked := true;
        'A': ToggleBox11.Checked := true;
        'S': ToggleBox12.Checked := true;
        'D': ToggleBox13.Checked := true;
        'F': ToggleBox14.Checked := true;
        'G': ToggleBox15.Checked := true;
        'H': ToggleBox16.Checked := true;
        'J': ToggleBox17.Checked := true;
        'K': ToggleBox18.Checked := true;
        'L': ToggleBox19.Checked := true;
        'Z': ToggleBox20.Checked := true;
        'X': ToggleBox21.Checked := true;
        'C': ToggleBox22.Checked := true;
        'V': ToggleBox23.Checked := true;
        'B': ToggleBox24.Checked := true;
        'N': ToggleBox25.Checked := true;
        'M': ToggleBox26.Checked := true;
      end;
      ShowMessage('Нет такой буквы!');
    end;

    Label2Draw;
  end;

  if (key = 13) and (Button1.Visible) then
    NewWord;
end;

procedure Tform1.ShowControls(SetMe: boolean);
begin
  Button1.Enabled := not SetMe;
  Button1.Visible := not SetMe;

  ToggleBox1.Visible := SetMe;
  ToggleBox2.Visible := SetMe;
  ToggleBox3.Visible := SetMe;
  ToggleBox4.Visible := SetMe;
  ToggleBox5.Visible := SetMe;
  ToggleBox6.Visible := SetMe;
  ToggleBox7.Visible := SetMe;
  ToggleBox8.Visible := SetMe;
  ToggleBox9.Visible := SetMe;
  ToggleBox10.Visible := SetMe;
  ToggleBox11.Visible := SetMe;
  ToggleBox12.Visible := SetMe;
  ToggleBox13.Visible := SetMe;
  ToggleBox14.Visible := SetMe;
  ToggleBox15.Visible := SetMe;
  ToggleBox16.Visible := SetMe;
  ToggleBox17.Visible := SetMe;
  ToggleBox18.Visible := SetMe;
  ToggleBox19.Visible := SetMe;
  ToggleBox20.Visible := SetMe;
  ToggleBox21.Visible := SetMe;
  ToggleBox22.Visible := SetMe;
  ToggleBox23.Visible := SetMe;
  ToggleBox24.Visible := SetMe;
  ToggleBox25.Visible := SetMe;
  ToggleBox26.Visible := SetMe;

  ToggleBox1.Checked := false;
  ToggleBox2.Checked := false;
  ToggleBox3.Checked := false;
  ToggleBox4.Checked := false;
  ToggleBox5.Checked := false;
  ToggleBox6.Checked := false;
  ToggleBox7.Checked := false;
  ToggleBox8.Checked := false;
  ToggleBox9.Checked := false;
  ToggleBox10.Checked := false;
  ToggleBox11.Checked := false;
  ToggleBox12.Checked := false;
  ToggleBox13.Checked := false;
  ToggleBox14.Checked := false;
  ToggleBox15.Checked := false;
  ToggleBox16.Checked := false;
  ToggleBox17.Checked := false;
  ToggleBox18.Checked := false;
  ToggleBox19.Checked := false;
  ToggleBox20.Checked := false;
  ToggleBox21.Checked := false;
  ToggleBox22.Checked := false;
  ToggleBox23.Checked := false;
  ToggleBox24.Checked := false;
  ToggleBox25.Checked := false;
  ToggleBox26.Checked := false;
end;

procedure Tform1.Label2Draw;
var
  i: integer;
begin
  Label3.Caption := 'Счёт слова = ' + IntToStr(Score[CurrentWord]);
  Label2.Caption := '';
  for i := 1 to Length(Words[CurrentWord, 1]) do
    if not Label2Open[i] then
      Label2.Caption := Label2.Caption + '?'
    else
    begin
      Label2.Caption := Label2.Caption + Words[CurrentWord, 1][i];
      case Words[CurrentWord, 1][i] of
        'Q': ToggleBox1.Visible := false;
        'W': ToggleBox2.Visible := false;
        'E': ToggleBox3.Visible := false;
        'R': ToggleBox4.Visible := false;
        'T': ToggleBox5.Visible := false;
        'Y': ToggleBox6.Visible := false;
        'U': ToggleBox7.Visible := false;
        'I': ToggleBox8.Visible := false;
        'O': ToggleBox9.Visible := false;
        'P': ToggleBox10.Visible := false;
        'A': ToggleBox11.Visible := false;
        'S': ToggleBox12.Visible := false;
        'D': ToggleBox13.Visible := false;
        'F': ToggleBox14.Visible := false;
        'G': ToggleBox15.Visible := false;
        'H': ToggleBox16.Visible := false;
        'J': ToggleBox17.Visible := false;
        'K': ToggleBox18.Visible := false;
        'L': ToggleBox19.Visible := false;
        'Z': ToggleBox20.Visible := false;
        'X': ToggleBox21.Visible := false;
        'C': ToggleBox22.Visible := false;
        'V': ToggleBox23.Visible := false;
        'B': ToggleBox24.Visible := false;
        'N': ToggleBox25.Visible := false;
        'M': ToggleBox26.Visible := false;
      end;
    end;
end;

procedure Tform1.NewWord;
var
  i, j: integer;
  Flg: boolean;
  LastWord: integer;
begin
  SaveScore;
  WrongLetters := '';
  LastWord := CurrentWord;
  ShowControls(true);
  repeat
    CurrentWord := Round(Random * (nWords - 1)) + 1;
    Flg := false;
    if (Score[CurrentWord] <= 3) or (Random < 1 / (Score[CurrentWord] + 1)) then
      Flg := true;
    if (Score[CurrentWord] = 0) and (Random > 0.1) then
      Flg := false;
  until (Flg) and (CurrentWord <> LastWord);
  Label1.Caption := Words[CurrentWord, 2];
  Flg := false;
  repeat
    for i := 1 to Length(Words[CurrentWord, 1]) do
      if (Random < 1 / (Score[CurrentWord] + 5)) and (Score[CurrentWord] < 10) then
        Label2Open[i] := true
      else
        Label2Open[i] := false;
    if Score[CurrentWord] < 6 then
    begin
      Label2Open[1] := true;
      if (Score[CurrentWord] < 4) and ((Length(Words[CurrentWord, 1]) > 3) or
        (Random < 0.5)) then
      begin
        j := 1;
        for i := 2 to Length(Words[CurrentWord, 1]) do
          if Label2Open[i] then
            Inc(j);
        if (Length(Words[CurrentWord, 1]) - j > 2) or (Random < 0.5) then
          Label2Open[2] := true;
      end;
    end;

    for i := 1 to Length(Words[CurrentWord, 1]) - 1 do
      for j := i + 1 to Length(Words[CurrentWord, 1]) do
        if Words[CurrentWord, 1][i] = Words[CurrentWord, 1][j] then
        begin
          Label2Open[i] := Label2Open[i] or Label2Open[j];
          Label2Open[j] := Label2Open[i] or Label2Open[j];
        end;
    for i := 1 to Length(Words[CurrentWord, 1]) do
      if Label2Open[i] = false then
        Flg := true;
  until Flg;

  Label2Draw;
end;

procedure Tform1.SaveScore;
var
  i: integer;
begin
  AssignFile(File2, 'parole.sco');
  Rewrite(File2);
  for i := 1 to nWords do
    Write(File2, Score[i]);
  CloseFile(File2);
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  nScore: integer;
begin
  AssignFile(File1, 'parole.txt');
  Reset(File1);
  nWords := 0;
  repeat
    Inc(nWords);
    readln(File1, Words[nWords, 1]);
    readln(File1, Words[nWords, 2]);
    Score[nWords] := 0;
  until EOF(File1);
  CloseFile(File1);

  AssignFile(File2, 'parole.sco');
  {$i-}
  Reset(File2);
  {$i+}
  if IOresult <> 0 then
    Rewrite(File2);
  for nScore := 1 to nWords do
    if not EOF(File2) then
      Read(File2, Score[nScore])
    else
      Score[nScore] := 0;
  CloseFile(File2);

  Randomize;
  NewWord;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  NewWord;
end;


initialization
  {$I unit1.lrs}

end.

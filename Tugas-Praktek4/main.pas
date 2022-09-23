unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  ExtCtrls, ExtDlgs, Windows;

type

  { TForm1 }

  TForm1 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    Loadbt: TButton;
    OpenPictureDialog1: TOpenPictureDialog;
    inisialisasiR: TRadioGroup;
    perbaikanR: TRadioGroup;
    Savebt: TButton;
    SavePictureDialog1: TSavePictureDialog;
    Scalingbt: TButton;
    TrackBar1: TTrackBar;
    procedure FormCreate(Sender: TObject);
    procedure GroupBox1Click(Sender: TObject);
    procedure GroupBox2Click(Sender: TObject);
    procedure LoadbtClick(Sender: TObject);
    procedure SavebtClick(Sender: TObject);
    procedure ScalingbtClick(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }
 var
   bitmapR,bitmapG,bitmapB: array[0..2000,0..2000] of integer;
   hasilR,hasilG,hasilB: array[0..2000,0..2000] of integer;

procedure TForm1.GroupBox1Click(Sender: TObject);
begin

end;

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

procedure TForm1.GroupBox2Click(Sender: TObject);
begin

end;

procedure TForm1.LoadbtClick(Sender: TObject);
var
  x,y:integer;
  begin
   if OpenPictureDialog1.Execute then
      begin
      Image1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
      for y:=0 to image1.Height-1 do
      begin
           for x:=0 to image1.Width-1 do
          begin
          bitmapR[x,y] := GetRValue(image1.Canvas.Pixels[x,y]);
          bitmapG[x,y] := GetGValue(image1.Canvas.Pixels[x,y]);
          bitmapB[x,y] := GetBValue(image1.Canvas.Pixels[x,y]);
          Label1.Caption := InttoStr(Trackbar1.Position);
       end;
     end;
   end;
end;

procedure TForm1.SavebtClick(Sender: TObject);
  begin
   if SavePictureDialog1.Execute then
   begin
   image2.Picture.SaveToFile(SavePictureDialog1.Filename);
   end;
  end;

procedure TForm1.ScalingbtClick(Sender: TObject);
var
  x , y , skala, choose , i , j : integer;
  intervalR , intervalG , intervalB: double;
begin
  image2.Canvas.Clear;
  skala := TrackBar1.Position;

  //inisialisasi
  choose := inisialisasiR.ItemIndex * 255;
  for y:=0 to (image1.Height-1)*skala do
  begin
    for x:=0 to (image1.Width-1)*skala do
    begin
      hasilR[x,y] := choose;
      hasilG[x,y] := choose;
      hasilB[x,y] := choose;
  end;
end;

  //scalling
  for y:=0 to image1.Height-1 do
  begin
    for x:=0 to image1.Width-1 do
    begin
      hasilR[round(x*skala),round(y*skala)] := bitmapR[x,y];
      hasilG[round(x*skala),round(y*skala)] := bitmapG[x,y];
      hasilB[round(x*skala),round(y*skala)] := bitmapB[x,y];
    end;
  end;

  //replikasi
  if perbaikanR.ItemIndex = 1 then
  begin
   for y:=0 to image1.Height-1 do
   begin
     for x:=0 to image1.Width-1 do
     begin
       for j:=1 to round(skala) do
       begin
         for i:=1 to round(skala) do
           begin
            hasilR[round(x*skala)+i, round(y*skala)+j] := bitmapR[x,y];
            hasilG[round(x*skala)+i, round(y*skala)+j] := bitmapG[x,y];
            hasilB[round(x*skala)+i, round(y*skala)+j] := bitmapB[x,y];
           end;
       end;
     end;
   end;
  end;

  //interpolasi
   if perbaikanR.ItemIndex = 2 then
   begin
   //horizontal
   for y:=0 to image1.Width-1 do
     begin
      for x:=0 to image2.Height-1 do
        begin
         intervalR := (bitmapR[x+1,y]-bitmapR[x,y])/skala;
         intervalG := (bitmapG[x+1,y]-bitmapG[x,y])/skala;
         intervalB := (bitmapB[x+1,y]-bitmapB[x,y])/skala;

          for i:=0 to skala do
          begin
            hasilR[round(x*skala)+i, round(y*skala)] := bitmapR[x,y] + round(i*intervalR);
            hasilG[round(x*skala)+i, round(y*skala)] := bitmapG[x,y] + round(i*intervalG);
            hasilB[round(x*skala)+i, round(y*skala)] := bitmapB[x,y] + round(i*intervalB);
          end;
        end;
     end;

     //vertical
     for y:=0 to image1.Height-1 do
     begin
       for x:=0 to (image1.Width-1)*skala do
       begin
         intervalR := (hasilR[x,round((y+1)*skala)]-hasilR[x,round(y*skala)])/skala;
         intervalG := (hasilG[x,round((y+1)*skala)]-hasilG[x,round(y*skala)])/skala;
         intervalB := (hasilB[x,round((y+1)*skala)]-hasilB[x,round(y*skala)])/skala;
          for j:=1 to round(skala-1) do
          begin
            hasilR[x, round(y*skala)+j] := round(hasilR[x,round(y*skala)] + j * intervalR);
            hasilG[x, round(y*skala)+j] := round(hasilG[x,round(y*skala)] + j * intervalG);
            hasilB[x, round(y*skala)+j] := round(hasilB[x,round(y*skala)] + j * intervalB);
            end;
          end;
       end;
     end;

  for y:=0 to (image1.Height-1)*skala do
  begin
    for x:=0 to (image1.Width-1)*skala do
    begin
      image2.Canvas.Pixels[x,y] := RGB(hasilR[x,y],hasilG[x,y],hasilB[x,y]);
    end;
  end;
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  Label1.Caption := InttoStr(Trackbar1.Position);
end;

end.


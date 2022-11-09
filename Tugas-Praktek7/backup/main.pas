unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  ExtCtrls, ExtDlgs, Windows;

type

  { TForm1 }

  TForm1 = class(TForm)
    zeroHPF: TButton;
    oneHPF: TButton;
    LPFButton: TButton;
    filteringButton: TButton;
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
    procedure filteringButtonClick(Sender: TObject);
    procedure LPFButtonClick(Sender: TObject);
    procedure oneHPFClick(Sender: TObject);
    procedure SavebtClick(Sender: TObject);
    procedure ScalingbtClick(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure zeroHPFClick(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }
 var
   bitmapR,bitmapG,bitmapB,bitmapGray , hasilR , hasilG, hasilB: array[-1..2000,-1..2000] of integer;
   lpf : array[-1..1,-1..1] of single;
   hpf : array[-1..1,-1..1] of integer;
   tempR , tempG , tempB : array [-1..2000,-1..2000] of integer;
   resR , resG , resB : array [-1..2000,-1..2000] of integer;

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
   for y:=0 to image1.Height-1 do
     begin
      for x:=0 to image1.Width-1 do
        begin
         hasilR[x*skala,y*skala] := bitmapR[x,y];
         hasilG[x*skala,y*skala] := bitmapG[x,y];
         hasilB[x*skala,y*skala] := bitmapB[x,y];
        end;
      end;

   //horizontal
   for y:=0 to image1.Width-1 do
     begin
      for x:=0 to image1.Height-1 do
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

procedure TForm1.filteringButtonClick(Sender: TObject);
var
  x , y : integer;
  filterR , filterG , filterB: integer;
begin
  for y:=0 to Height-1 do
  begin
    for x:=0 to Width-1 do
    begin
      filterR := (bitmapR[x,y] + bitmapR[x-1,y-1] + bitmapR[x+1,y+1] + bitmapR[x-1,y] + bitmapR[x,y-1] + bitmapR[x+1,y-1] + bitmapR[x-1,y+1] + bitmapR[x+1,y] + bitmapR[x,y+1])div 9;
      filterG := (bitmapG[x,y] + bitmapG[x-1,y-1] + bitmapG[x+1,y+1] + bitmapG[x-1,y] + bitmapG[x,y-1] + bitmapG[x+1,y-1] + bitmapG[x-1,y+1] + bitmapG[x+1,y] + bitmapG[x,y+1])div 9;
      filterB := (bitmapB[x,y] + bitmapB[x-1,y-1] + bitmapB[x+1,y+1] + bitmapB[x-1,y] + bitmapB[x,y-1] + bitmapB[x+1,y-1] + bitmapB[x-1,y+1] + bitmapB[x+1,y] + bitmapB[x,y+1])div 9;
      image2.Canvas.Pixels[x,y] := RGB(filterR , filterG , filterB);
    end;
  end;
end;

procedure TForm1.LPFButtonClick(Sender: TObject);
var
  x,y,i,j : Integer;
  tempR , tempG , tempB : single;
begin

  lpf[-1,-1] := 0;
  lpf[-1,0] := 0.125;
  lpf[-1,1] := 0;
  lpf[0,-1] := 0.125;
  lpf[0,0]:= 0.5;
  lpf[0,1] := 0.125;
  lpf[1,-1] := 0;
  lpf[1,0] := 0.125;
  lpf[1,1] := 0;

  for y:=0 to height-1 do
  begin
    for x:=0 to width-1 do
    begin
      tempR:=0;
      tempG:=0;
      tempB:=0;

      for j:=-1 to 1 do
      begin
        for i:=-1 to 1 do
        begin
          tempR := tempR + bitmapR[x+i,y+j] * lpf[-1,-j];
          tempG := tempG + bitmapG[x+i,y+j] * lpf[-1,-j];
          tempB := tempB + bitmapB[x+i,y+j] * lpf[-1,-j];
        end;
      end;
      resR[x,y] := round(tempR);
      resG[x,y] := round(tempG);
      resB[x,y] := round(tempB);
      image2.Canvas.Pixels[x,y] := RGB(resR[x,y],resG[x,y],resB[x,y]);
    end;
  end;



end;

procedure TForm1.oneHPFClick(Sender: TObject);
var
 x,y,i,j : integer;
begin
 for j:=-1 to 1 do
 begin
   for i:=-1 to 1 do
   begin
     hpf[i,j] := -1;
   end;
 end;
 hpf[0,0] := 9;

 for y:=0 to Height-1 do
 begin
   for x:=0 to Width-1 do
   begin
     for j:=-1 to 1 do
     begin
       for i:=-1 to 1 do
       begin
         tempR[x,y] := tempR[x,y] + bitmapR[x+i,y+j] * hpf[-i,-j];
         tempG[x,y] := tempG[x,y] + bitmapG[x+i,y+j] * hpf[-i,-j];
         tempB[x,y] := tempB[x,y] + bitmapB[x+i,y+j] * hpf[-i,-j];
         resR[x,y] := round(tempR[x,y]);
         resG[x,y] := round(tempG[x,y]);
         resB[x,y] := round(tempB[x,y]);
       end;
     end;
      if (round(tempR[x,y]) < 0) then
      resR[x,y] := 0;
      if (round(tempR[x,y]) > 255) then
      resR[x,y] := 255;

       if (round(tempG[x,y]) < 0) then
      resG[x,y] := 0;
      if (round(tempG[x,y])> 255) then
      resG[x,y] := 255;

       if (round(tempB[x,y]) < 0) then
      resB[x,y] := 0;
      if (round(tempB[x,y]) > 255) then
      resB[x,y] := 255;
      image2.Canvas.Pixels[x,y] := RGB(resR[x,y],resG[x,y],resB[x,y]);
   end;
end;

end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  Label1.Caption := InttoStr(Trackbar1.Position);
end;

procedure TForm1.zeroHPFClick(Sender: TObject);
var
 x,y,i,j : integer;
begin
 for j:=-1 to 1 do
 begin
   for i:=-1 to 1 do
   begin
     hpf[i,j] := -1;
   end;
 end;
 hpf[0,0] := 8;

 for y:=0 to Height-1 do
 begin
   for x:=0 to Width-1 do
   begin
     for j:=-1 to 1 do
     begin
       for i:=-1 to 1 do
       begin
         tempR := tempR + bitmapR[x+i,y+j] * hpf[-i,-j];
         tempG := tempG + bitmapG[x+i,y+j] * hpf[-i,-j];
         tempB := tempB + bitmapB[x+i,y+j] * hpf[-i,-j];
       end;
     end;
      resR[x,y] := round(tempR);
      resG[x,y] := round(tempG);
      resB[x,y] := round(tempB);
      //mau beneri
      if (tempR < 0) then
      resR[x,y] := 0;
      if (tempR > 255) then
      resR[x,y] := 255;

       if (tempG < 0) then
      resG[x,y] := 0;
      if (tempG > 255) then
      resG[x,y] := 255;

       if (tempB < 0) then
      resB[x,y] := 0;
      if (tempB > 255) then
      resB[x,y] := 255;
      image2.Canvas.Pixels[x,y] := RGB(resR[x,y],resG[x,y],resB[x,y]);
   end;
end;

end;

end.


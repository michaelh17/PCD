unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ExtDlgs, Windows;

type

  { TForm1 }

  TForm1 = class(TForm)
    clearButton: TButton;
    OpenPictureDialog1: TOpenPictureDialog;
    originalImage: TImage;
    atasImage: TImage;
    kiriImage: TImage;
    kananImage: TImage;
    bawahImage: TImage;
    ComboBox1: TComboBox;
    loadButton: TButton;
    procedure clearButtonClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure loadButtonClick(Sender: TObject);
  private

  public

  end;
var
  bitmapR, bitmapG, bitmapB, bitmapGray : array [-1..2000,-1..2000] of integer;
  tempAtas, tempKanan, tempBawah, tempKiri, resAtas, resKanan, resBawah, resKiri : array[-1..2000,-1..2000] of integer;
  tinggi, lebar : integer;
  filterAtas, filterBawah, filterKiri, filterKanan : array [-1..1,-1..1] of integer;
var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.ComboBox1Change(Sender: TObject);
var
  x,y,i,j : integer;
begin
  atasImage.Picture := originalImage.Picture;
  kananImage.Picture := originalImage.Picture;
  bawahImage.Picture := originalImage.Picture;
  kiriImage.Picture := originalImage.Picture;

  //Sobell
  if ComboBox1.ItemIndex = 0 then
      begin
      for y:=0 to tinggi-1 do
      begin
      for x:=0  to lebar-1 do
      begin
      tempAtas[x,y] := 0;
      resAtas[x,y] := 0;

      tempKanan[x,y] := 0;
      resKanan[x,y] := 0;

      tempBawah[x,y] := 0;
      resBawah[x,y] := 0;

      tempKiri[x,y] := 0;
      resKiri[x,y] := 0;
      end;
      end;

      //filter atas
      filterAtas[-1,-1] := -1; filterAtas[0,-1] := -2; filterAtas[1,-1] := -1;
      filterAtas[-1,0] := 0;  filterAtas[0,0]:= 0;  filterAtas[1,0] := 0;
      filterAtas[-1,1] := 1;  filterAtas[0,1] := 2; filterAtas[1,1] := 1;

       //filter kanan
      filterKanan[-1,-1] := 1; filterKanan[0,-1] := 0; filterKanan[1,-1] := -1;
      filterKanan[-1,0] := 2;  filterKanan[0,0]:= 0;  filterKanan[1,0] := -2;
      filterKanan[-1,1] := 1;  filterKanan[0,1] := 0; filterKanan[1,1] := -1;

       //filter bawah
      filterBawah[-1,-1] := 1; filterBawah[0,-1] := 2; filterBawah[1,-1] := 1;
      filterBawah[-1,0] := 0;  filterBawah[0,0]:= 0;  filterBawah[1,0] := 0;
      filterBawah[-1,1] := -1;  filterBawah[0,1] := -2; filterBawah[1,1] := -1;

      //filter kiri
      filterKiri[-1,-1] := -1; filterKiri[0,-1] := 0; filterKiri[1,-1] := 1;
      filterKiri[-1,0] := -2;  filterKiri[0,0]:= 0;  filterKiri[1,0] := 2;
      filterKiri[-1,1] := -1;  filterKiri[0,1] := 0; filterKiri[1,1] := 1;

      //Sobell
       for y:=0 to tinggi-1 do
       begin
       for x:=0 to lebar-1 do
       begin
       for j:=-1 to 1 do
       begin
       for i:=-1 to 1 do
       begin
         tempAtas[x,y] := tempAtas[x,y] + bitmapGray[x+i,y+j] * filterAtas[-i,-j];
         resAtas[x,y] := round(tempAtas[x,y]);

         tempKanan[x,y] := tempKanan[x,y] + bitmapGray[x+i,y+j] * filterKanan[-i,-j];
         resKanan[x,y] := round(tempKanan[x,y]);

         tempBawah[x,y] := tempBawah[x,y] + bitmapGray[x+i,y+j] * filterBawah[-i,-j];
         resBawah[x,y] := round(tempBawah[x,y]);

         tempKiri[x,y] := tempKiri[x,y] + bitmapGray[x+i,y+j] * filterKiri[-i,-j];
         resKiri[x,y] := round(tempKiri[x,y]);
         end;
       end;

      if (round(tempAtas[x,y]) < 0) then
      resAtas[x,y] := 0;
      if (round(tempAtas[x,y]) > 255) then
      resAtas[x,y] := 255;

      if (round(tempKanan[x,y]) < 0) then
      resKanan[x,y] := 0;
      if (round(tempKanan[x,y]) > 255) then
      resKanan[x,y] := 255;

      if (round(tempBawah[x,y]) < 0) then
      resBawah[x,y] := 0;
      if (round(tempBawah[x,y]) > 255) then
      resBawah[x,y] := 255;

      if (round(tempKiri[x,y]) < 0) then
      resKiri[x,y] := 0;
      if (round(tempKiri[x,y]) > 255) then
      resKiri[x,y] := 255;

      atasImage.Canvas.Pixels[x,y] := RGB(resAtas[x,y],resAtas[x,y],resAtas[x,y]);
      kananImage.Canvas.Pixels[x,y] := RGB(resKanan[x,y],resKanan[x,y],resKanan[x,y]);
      bawahImage.Canvas.Pixels[x,y] := RGB(resBawah[x,y],resBawah[x,y],resBawah[x,y]);
      kiriImage.Canvas.Pixels[x,y] := RGB(resKiri[x,y],resKiri[x,y],resKiri[x,y]);
      end;
    end;
  end;


  //Prewitt
  if ComboBox1.ItemIndex = 1 then
      begin

      //filter atas
      filterAtas[-1,-1] := -1; filterAtas[0,-1] := -1; filterAtas[1,-1] := -1;
      filterAtas[-1,0] := 0;  filterAtas[0,0]:= 0;  filterAtas[1,0] := 0;
      filterAtas[-1,1] := 1;  filterAtas[0,1] := 1; filterAtas[1,1] := 1;

       //filter kanan
      filterKanan[-1,-1] := 1; filterKanan[0,-1] := 0; filterKanan[1,-1] := -1;
      filterKanan[-1,0] := 1;  filterKanan[0,0]:= 0;  filterKanan[1,0] := -1;
      filterKanan[-1,1] := 1;  filterKanan[0,1] := 0; filterKanan[1,1] := -1;

       //filter bawah
      filterBawah[-1,-1] := 1; filterBawah[0,-1] := 1; filterBawah[1,-1] := 1;
      filterBawah[-1,0] := 0;  filterBawah[0,0]:= 0;  filterBawah[1,0] := 0;
      filterBawah[-1,1] := -1;  filterBawah[0,1] := -1; filterBawah[1,1] := -1;

      //filter kiri
      filterKiri[-1,-1] := -1; filterKiri[0,-1] := 0; filterKiri[1,-1] := 1;
      filterKiri[-1,0] := -1;  filterKiri[0,0]:= 0;  filterKiri[1,0] := 1;
      filterKiri[-1,1] := -1;  filterKiri[0,1] := 0; filterKiri[1,1] := 1;

      //Prewitt
       for y:=0 to tinggi-1 do
       begin
       for x:=0 to lebar-1 do
       begin
       for j:=-1 to 1 do
       begin
       for i:=-1 to 1 do
       begin
         tempAtas[x,y] := tempAtas[x,y] + bitmapGray[x+i,y+j] * filterAtas[-i,-j];
         resAtas[x,y] := round(tempAtas[x,y]);

         tempKanan[x,y] := tempKanan[x,y] + bitmapGray[x+i,y+j] * filterKanan[-i,-j];
         resKanan[x,y] := round(tempKanan[x,y]);

         tempBawah[x,y] := tempBawah[x,y] + bitmapGray[x+i,y+j] * filterBawah[-i,-j];
         resBawah[x,y] := round(tempBawah[x,y]);

         tempKiri[x,y] := tempKiri[x,y] + bitmapGray[x+i,y+j] * filterKiri[-i,-j];
         resKiri[x,y] := round(tempKiri[x,y]);
         end;
       end;

      if (round(tempAtas[x,y]) < 0) then
      resAtas[x,y] := 0;
      if (round(tempAtas[x,y]) > 255) then
      resAtas[x,y] := 255;

      if (round(tempKanan[x,y]) < 0) then
      resKanan[x,y] := 0;
      if (round(tempKanan[x,y]) > 255) then
      resKanan[x,y] := 255;

      if (round(tempBawah[x,y]) < 0) then
      resBawah[x,y] := 0;
      if (round(tempBawah[x,y]) > 255) then
      resBawah[x,y] := 255;

      if (round(tempKiri[x,y]) < 0) then
      resKiri[x,y] := 0;
      if (round(tempKiri[x,y]) > 255) then
      resKiri[x,y] := 255;

      atasImage.Canvas.Pixels[x,y] := RGB(resAtas[x,y],resAtas[x,y],resAtas[x,y]);
      kananImage.Canvas.Pixels[x,y] := RGB(resKanan[x,y],resKanan[x,y],resKanan[x,y]);
      bawahImage.Canvas.Pixels[x,y] := RGB(resBawah[x,y],resBawah[x,y],resBawah[x,y]);
      kiriImage.Canvas.Pixels[x,y] := RGB(resKiri[x,y],resKiri[x,y],resKiri[x,y]);
      end;
    end;
end;
end;

procedure TForm1.clearButtonClick(Sender: TObject);
begin
  atasImage.Canvas.Clear;
  kananImage.Canvas.Clear;
  bawahImage.Canvas.Clear;
  kiriImage.Canvas.Clear;
end;

procedure TForm1.loadButtonClick(Sender: TObject);
var
  x,y : integer;
begin
  if OpenPictureDialog1.Execute then
      begin
      originalImage.Picture.LoadFromFile(OpenPictureDialog1.FileName);
      for y:=0 to originalImage.Height-1 do
      begin
           for x:=0 to originalImage.Width-1 do
          begin
          bitmapR[x,y] := GetRValue(originalImage.Canvas.Pixels[x,y]);
          bitmapG[x,y] := GetGValue(originalImage.Canvas.Pixels[x,y]);
          bitmapB[x,y] := GetBValue(originalImage.Canvas.Pixels[x,y]);
          originalImage.Canvas.Pixels[x,y] := RGB(bitmapR[x,y],bitmapG[x,y],bitmapB[x,y]);
       end;
     end;

       for y:=0 to Height-1 do
      begin
      for x:=0 to Width-1 do
      begin
      bitmapGray[x,y] := (bitmapR[x,y] + bitmapB[x,y] + bitmapG[x,y]) div 3;
      end;
      end;

      for x:=0 to originalImage.Width-1 do
           begin
           bitmapGray[x,-1] := bitmapGray[x,0];
           bitmapGray[x,Height-1] := bitmapGray[x,Height-1];
           end;


           for y:=0 to originalImage.Height-1 do
           begin
           bitmapGray[-1,-y] := bitmapGray[0,y];
           bitmapGray[Width,y] := bitmapGray[Width-1,y];
           end;

           lebar := originalImage.Width;
           tinggi := originalImage.Height;

   end;
end;

end.


unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ExtDlgs, ComCtrls, Windows;
type

  { TForm1 }



  TForm1 = class(TForm)
    Button1: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    OpenPictureDialog1: TOpenPictureDialog;
    SavePictureDialog1: TSavePictureDialog;
    TrackBar1: TTrackBar;
    TrackBar2: TTrackBar;
    TrackBar3: TTrackBar;
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure TrackBar3Change(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }
    var
       bitmapR , bitmapG , bitmapB , bitmapGray: array [0..1000,0..1000] of integer;
       bitmapBiner: array[0..1000,0..1000] of boolean;


procedure TForm1.Label1Click(Sender: TObject);
begin

end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  Label3.Caption:= InttoStr(Trackbar1.Position);
end;

procedure TForm1.TrackBar2Change(Sender: TObject);
begin
  Label4.Caption:= InttoStr(Trackbar2.Position);
end;

procedure TForm1.TrackBar3Change(Sender: TObject);
begin
  Label5.Caption:= InttoStr(Trackbar3.Position);
end;

procedure TForm1.Button1Click(Sender: TObject);

var
  x,y : integer;

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
        end;
      end;
  end;

end;

procedure TForm1.Button10Click(Sender: TObject);
var
  x,y : integer;
  gray : integer;
begin
  for y:=0 to image1.Height-1 do
  begin
    for x:=0 to image1.Width-1 do
    begin
     gray:= (bitmapR[x,y] + bitmapG[x,y] + bitmapB[x,y]) div 3;
       if (gray <= TrackBar1.Position) then
       begin
          bitmapBiner[x,y] := False;
       end;
       if (gray > TrackBar1.Position) then
         begin
            bitmapBiner[x,y] := True;
       end;
    end;
  end;
end;

procedure TForm1.Button11Click(Sender: TObject);
var
  x,y : integer;
  brightnessR , brightnessG , brightnessB : integer;
begin
  for y:=0 to image1.Height-1 do
  begin
   for x:=0 to image1.Width-1 do
   begin
    brightnessR := bitmapR[x,y] + Trackbar2.Position;
     if brightnessR < 0 then brightnessR := 0;
     if brightnessR > 255 then brightnessR := 255;

    brightnessG := bitmapG[x,y] + Trackbar2.Position;
     if brightnessG < 0 then brightnessG := 0;
     if brightnessG > 255 then brightnessG := 255;

    brightnessB := bitmapB[x,y] + Trackbar2.Position;
     if brightnessB < 0 then brightnessB := 0;
     if brightnessB > 255 then brightnessB := 255;
    image2.Canvas.Pixels[x,y] := RGB(brightnessR,brightnessG,brightnessB);
end;
end;

end;

procedure TForm1.Button12Click(Sender: TObject);
var
  x,y:integer;
    begin
    for y:=0 to image1.Height-1 do
    begin
      for x:=0 to image1.Width-1 do
      begin
       image2.Canvas.Pixels[x,y] := RGB(bitmapR[x,y],0,0);
      end;
    end;
end;
procedure TForm1.Button13Click(Sender: TObject);
var
  x,y:integer;
    begin
    for y:=0 to image1.Height-1 do
    begin
      for x:=0 to image1.Width-1 do
      begin
       image2.Canvas.Pixels[x,y] := RGB(0,0,bitmapB[x,y]);
      end;
    end;
end;

procedure TForm1.Button14Click(Sender: TObject);
var
  x,y:integer;
    begin
    for y:=0 to image1.Height-1 do
    begin
      for x:=0 to image1.Width-1 do
      begin
       image2.Canvas.Pixels[x,y] := RGB(0,bitmapG[x,y],0);
      end;
    end;
end;

procedure TForm1.Button15Click(Sender: TObject);
var
  x,y : integer;
  contrastR , contrastG , contrastB : integer;
begin
  for y:=0 to image1.Height-1 do
  begin
   for x:=0 to image1.Width-1 do
   begin
    contrastR := 2 * (bitmapR[x,y] - Trackbar3.Position) + Trackbar3.Position;
     if contrastR < 0 then contrastR := 0;
     if contrastR > 255 then contrastR := 255;

    contrastG := 2 * (bitmapG[x,y] - Trackbar3.Position) + Trackbar3.Position;
     if contrastG < 0 then contrastG := 0;
     if contrastG > 255 then contrastG := 255;

    contrastB := 2 * (bitmapB[x,y] - Trackbar3.Position) + Trackbar3.Position;
     if contrastB < 0 then contrastB := 0;
     if contrastB > 255 then contrastB := 255;
    image2.Canvas.Pixels[x,y] := RGB(contrastR,contrastG,contrastB);
end;
end;

end;

procedure TForm1.Button16Click(Sender: TObject);
var
  x,y : integer;
  inversR , inversG , inversB : integer;
begin
  for y:=0 to image1.Height-1 do
  begin
   for x:=0 to image1.Width-1 do
   begin
    inversR := 255 - bitmapR[x,y];
     if inversR < 0 then inversR := 0;
     if inversR > 255 then inversR := 255;

    inversG := 255 - bitmapG[x,y];
     if inversG < 0 then inversG := 0;
     if inversG > 255 then inversG := 255;

    inversB := 255 - bitmapB[x,y];
     if inversB < 0 then inversB := 0;
     if inversB > 255 then inversB := 255;
    image2.Canvas.Pixels[x,y] := RGB(inversR,inversG,inversB);
end;
end;
end;
procedure TForm1.Button2Click(Sender: TObject);
  var
    x,y : integer;
    begin
    for y:=0 to image1.Height-1 do
    begin
      for x:=0 to image1.Width-1 do
      begin
        image2.Canvas.Pixels[x,y] := RGB(bitmapR[x,y], bitmapG[x,y], bitmapB[x,y]);
        end;
      end;
    end;

procedure TForm1.Button3Click(Sender: TObject);
var
  x,y:integer;
    begin
    for y:=0 to image1.Height-1 do
    begin
      for x:=0 to image1.Width-1 do
      begin
        if bitmapBiner[x,y] = True then
        Image2.Canvas.Pixels[x,y] := RGB(255,255,255)

        else
          Image2.Canvas.Pixels[x,y] := RGB(255,0,0)
        end;
      end;
    end;

procedure TForm1.Button4Click(Sender: TObject);
var
 x, y : integer;
    begin
    for y:=0 to image1.Height-1 do
    begin
      for x:=0 to image1.Width-1 do
      begin
        if bitmapBiner[x,y] = True then
        Image2.Canvas.Pixels[x,y] := RGB(255,255,255)

        else
          Image2.Canvas.Pixels[x,y] := RGB(0,255,0)
      end;
    end;

end;

procedure TForm1.Button5Click(Sender: TObject);
var
 x, y : integer;
    begin
    for y:=0 to image1.Height-1 do
    begin
      for x:=0 to image1.Width-1 do
      begin
        if bitmapBiner[x,y] = True then
        Image2.Canvas.Pixels[x,y] := RGB(255,255,255)

        else
          Image2.Canvas.Pixels[x,y] := RGB(0,0,255)
      end;
    end;

end;

procedure TForm1.Button6Click(Sender: TObject);
var
  x,y : integer;
begin
     for y:=0 to image1.Height-1 do
     begin
       for x:=0 to image1.Width-1 do
       begin
         bitmapGray[x,y] := (bitmapR[x,y] + bitmapG[x,y] + bitmapB[X,Y]) div 3;
         image2.Canvas.Pixels[x,y] := RGB(bitmapGray[x,y],bitmapGray[x,y],bitmapGray[x,y]);
       end;
     end;
end;

procedure TForm1.Button7Click(Sender: TObject);
var
  x,y : integer;
  gray : byte;
  biner : byte;
  treshold : integer;
begin
     treshold := 100;
     for y:=0 to image1.Height-1 do
     begin
       for x:=0 to image1.Width-1 do
       begin
         gray:= (bitmapR[x,y] + bitmapG[x,y] + bitmapB[x,y]) div 3;
         if (gray<treshold) then
         biner:= 0
         else
           biner:=255;

         image2.Canvas.Pixels[x,y] := RGB(biner,biner,biner);

       end;
     end;

end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  if SavePictureDialog1.Execute then
  begin
      image2.Picture.SaveToFile(SavePictureDialog1.Filename);
  end;
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
  close;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

procedure TForm1.Image1Click(Sender: TObject);
begin

end;

procedure TForm1.Image2Click(Sender: TObject);
begin

end;

end.


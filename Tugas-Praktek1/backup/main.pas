unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ExtDlgs, Windows;
type

  { TForm1 }



  TForm1 = class(TForm)
    Button1: TButton;
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
    OpenPictureDialog1: TOpenPictureDialog;
    SavePictureDialog1: TSavePictureDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }
    var
       bitmapR , bitmapG , bitmapB : array [0..1000,0..1000] of integer;
procedure TForm1.Label1Click(Sender: TObject);
begin

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

procedure TForm1.Button2Click(Sender: TObject);

  var
    x,y : integer;
    begin
    for y:=0 to image1.Height do
    begin
      for x:=0 to image1.Width do
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
        Image2.Canvas.Pixels[x,y] := RGB(bitmapR[x,y],0,0);
      end;
    end;

end;

procedure TForm1.Button4Click(Sender: TObject);
var
  x,y:integer;
    begin
    for y:=0 to image1.Height-1 do
    begin
      for x:=0 to image1.Width-1 do
      begin
        Image2.Canvas.Pixels[x,y] := RGB(0,bitmapG[x,y],0);
      end;
    end;

end;

procedure TForm1.Button5Click(Sender: TObject);
var
  x,y:integer;
    begin
    for y:=0 to image1.Height-1 do
    begin
      for x:=0 to image1.Width-1 do
      begin
        Image2.Canvas.Pixels[x,y] := RGB(0,0,bitmapB[x,y]);
      end;
    end;

end;

procedure TForm1.Button6Click(Sender: TObject);
var
  x,y : integer;
  gray : integer;
begin
     for y:=0 to image1.Height-1 do
     begin
       for x:=0 to image1.Width-1 do
       begin
         gray:= (bitmapR[x,y] + bitmapG[x,y] + bitmapB[x,y]) div 3;

         image2.Canvas.Pixels[x,y] := RGB(gray,gray,gray);
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

procedure TForm1.Image1Click(Sender: TObject);
begin

end;

procedure TForm1.Image2Click(Sender: TObject);
begin

end;

end.


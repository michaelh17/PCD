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
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
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
    TrackBar1: TTrackBar;
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
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

begin

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


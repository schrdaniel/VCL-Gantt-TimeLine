unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ComCtrls,
  Vcl.Samples.Spin;

type
  TScrollBox = class(VCL.Forms.TScrollBox)
    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
  private
    FOnScrollVert: TNotifyEvent;
    FOnScrollHorz: TNotifyEvent;
  public
    property OnScrollVert: TNotifyEvent read FOnScrollVert write FonScrollVert;
    property OnScrollHorz: TNotifyEvent read FOnScrollHorz write FonScrollHorz;
  end;

type
  TMainFrm = class(TForm)
    pnl_top_bar: TPanel;
    MouseTimer: TTimer;
    StatusBar1: TStatusBar;
    display_date: TDateTimePicker;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    pnl_gantt: TPanel;
    Splitter1: TSplitter;
    pointer: TImage;
    pnl_main: TPanel;
    box_main: TScrollBox;
    pnl_left: TPanel;
    box_left: TScrollBox;
    def_panel: TPanel;
    pointer_line: TPanel;
    pnl_right: TPanel;
    btn_minus: TButton;
    btn_plus: TButton;

    procedure ShowVisilbeRecords;
    procedure ChangeDate;
    procedure ChangeHourWidth;

    procedure InsertObject(record_name, from_time, to_time, memo: string; canvas_color, text_color: TColor);
    procedure ClearAllObjects;
    procedure CreateAllObjectsOnDate;

    procedure FormCreate(Sender: TObject);
    procedure MouseTimerTimer(Sender: TObject);
    procedure box_leftResize(Sender: TObject);
    procedure display_dateChange(Sender: TObject);
    procedure def_panelClick(Sender: TObject);
    procedure def_panel_nameClick(Sender: TObject);
    procedure btn_minusClick(Sender: TObject);
    procedure btn_plusClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    const
      ile_max_rekordow = 100;
    var
      tab_hours: array[0..23] of TPanel;
      tab_minuts: array[0..23] of TPanel;
      tab_rec: array[1..ile_max_rekordow] of TPanel;
      tab_rec_name: array[1..ile_max_rekordow] of TPanel;
      pnl_pointer: TPanel;
      pnl_height: Integer;
      pnl_width: Integer;
      pnl_pom: TPanel;
      minute_width: Integer;

    procedure MyScrollVert(Sender: TObject);
    procedure MyScrollVert2(Sender: TObject);

    procedure CreateHourPanels;
    procedure CreateRecords;

  public
    { Public declarations }
  end;

var
  MainFrm: TMainFrm;

implementation

{$R *.dfm}

procedure TScrollBox.WMVScroll(var Message: TWMVScroll);
begin
  inherited;
  if Assigned(FOnScrollVert) then
    FOnScrollVert(Self);
end;

procedure TMainFrm.CreateAllObjectsOnDate;
begin
  {InsertObject('Company project', '01:15', '03:25', 'Design: dap.365' + #13 + 'Analysis of the 4th phase of the project', clBlue, clWhite);
  InsertObject('Home project', '03:15', '03:35', 'Houseworks' + #13 + 'Living room', clRed, clBlack);
  InsertObject('Task 1', '03:40', '05:25', 'Data analysis' + #13 + 'Project dap.365', clBlue, clWhite);
  InsertObject('Waiting', '02:10', '03:45', 'Review of other tasks', clBlue, clWhite);
  InsertObject('Waiting', '03:10', '04:45', 'Review of other tasks', clBlue, clWhite);
  InsertObject('Waiting', '04:10', '05:45', 'Review of other tasks', clBlue, clWhite);
  InsertObject('Waiting', '05:10', '06:45', 'Review of other tasks', clBlue, clWhite);
  InsertObject('Waiting', '06:10', '07:45', 'Review of other tasks', clBlue, clWhite);
  InsertObject('Waiting', '07:10', '08:45', 'Review of other tasks', clBlue, clWhite);
  InsertObject('Waiting', '08:10', '09:45', 'Review of other tasks', clBlue, clWhite);
  InsertObject('Waiting', '08:10', '09:45', 'Review of other tasks', clBlue, clWhite);
  InsertObject('Waiting', '08:10', '09:45', 'Review of other tasks', clBlue, clWhite);
  InsertObject('Waiting', '10:10', '11:45', 'Review of other tasks', clBlue, clWhite);
  InsertObject('Waiting', '11:10', '12:45', 'Review of other tasks', clBlue, clWhite);
  InsertObject('Waiting', '12:10', '14:45', 'Review of other tasks', clBlue, clWhite);

  InsertObject('Task 1', '13:40', '15:25', 'Data analysis' + #13 + 'Project dap.365', clBlue, clWhite);}

  InsertObject('pnl: 1', '3:40', '8:25', 'Data analysis' + #13 + 'Teste 123', clBlue, clWhite);
  InsertObject('pnl: 2', '4:40', '5:25', 'Data analysis' + #13 + 'Teste 123', clBlue, clWhite);
  InsertObject('pnl: 3', '5:40', '6:25', 'Data analysis' + #13 + 'Teste 123', clBlue, clWhite);
  InsertObject('pnl: 4', '6:40', '8:25', 'Data analysis' + #13 + 'Teste 123', clBlue, clWhite);
  InsertObject('pnl: 5', '7:40', '15:25', 'Data analysis' + #13 + 'Teste 123', clBlue, clWhite);
  InsertObject('pnl: 6', '8:40', '15:25', 'Data analysis' + #13 + 'Teste 123', clBlue, clWhite);
  InsertObject('pnl: 7', '9:40', '15:25', 'Data analysis' + #13 + 'Teste 123', clBlue, clWhite);
  InsertObject('pnl: 8', '10:40', '11:25', 'Data analysis' + #13 + 'Teste 123', clBlue, clWhite);
  InsertObject('pnl: 9', '13:40', '15:25', 'Data analysis' + #13 + 'Teste 123', clBlue, clWhite);
  InsertObject('pnl: 10', '13:40', '15:25', 'Data analysis' + #13 + 'Teste 123', clBlue, clWhite);
  InsertObject('pnl: 11', '13:40', '15:25', 'Data analysis' + #13 + 'Teste 123', clBlue, clWhite);
  InsertObject('pnl: 12', '13:40', '15:25', 'Data analysis' + #13 + 'Teste 123', clBlue, clWhite);
  InsertObject('pnl: 13', '13:40', '15:25', 'Data analysis' + #13 + 'Teste 123', clBlue, clWhite);
  InsertObject('pnl: 14', '13:40', '15:25', 'Data analysis' + #13 + 'Teste 123', clBlue, clWhite);
  InsertObject('pnl: 15', '13:40', '15:25', 'Data analysis' + #13 + 'Teste 123', clBlue, clWhite);
  InsertObject('pnl: 16', '13:40', '15:25', 'Data analysis' + #13 + 'Teste 123', clBlue, clWhite);

  //InsertObject('pnl: 17', '00:00', '00:00', '' + #13 + '', clBlack, clBlack);
  //InsertObject('pnl: 18', '00:00', '00:00', '' + #13 + '', clBlack, clBlack);
  //InsertObject('pnl: 19', '00:00', '00:00', '' + #13 + '', clBlack, clBlack);

  InsertObject('pnl: 20', '13:40', '15:25', 'Teste' + #13 + 'Teste 123', clRed, clYellow);
  InsertObject('pnl: 30', '15:40', '16:25', 'Teste' + #13 + 'Teste 123', clBlack, clYellow);
  InsertObject('pnl: 40', '16:40', '17:25', 'Teste' + #13 + 'Teste 123', clPurple, clYellow);

end;

procedure TMainFrm.ClearAllObjects;
var
  i: Integer;
  c: Integer;
begin
  for i := 1 to ile_max_rekordow do
  begin
    for c := tab_rec[i].ControlCount - 1 downto 0 do
    begin
      tab_rec[i].Controls[c].Destroy;
    end;
  end;
end;

procedure TMainFrm.InsertObject(record_name, from_time, to_time, memo: string; canvas_color, text_color: TColor);
var
  new_object: TPanel;
  new_label: TLabel;
  new_shape: TShape;
  i: Integer;
  hourS, minuteS: string;
  poz: Integer;
  hour, minute: Integer;
  left: Integer;
  end_time: Integer;
  width_pos: Integer;
begin
  new_object := TPanel.Create(Self);
  for i := 1 to ile_max_rekordow do
  begin
    if tab_rec_name[i].Caption = record_name then
    begin
      new_object.Parent := tab_rec[i];

      tab_rec[i].Visible := True;
      tab_rec_name[i].Visible := True;

      tab_rec[i].Height := 64;
      tab_rec_name[i].Height := 64;

    end;
  end;

  new_object.Top := 0;
  new_object.Height := (pnl_height * 2) - 4;
  new_object.BevelKind := bkFlat;
  new_object.BevelOuter := bvNone;
  new_object.StyleElements := [];
  new_object.ShowHint := True;
  new_object.Hint := record_name + #13#13 + memo + #13#13 + 'From: ' + from_time + #13 + 'To: ' + to_time;

  poz := Pos(':', from_time);
  hourS := Trim(Copy(from_time, 1, poz - 1));
  Delete(from_time, 1, poz);
  minuteS := Trim(from_time);
  hour := StrToInt(hourS);
  minute := (hour * 60) + StrToInt(minuteS);
  left := minute * minute_width;

  poz := Pos(':', to_time);
  hourS := Trim(Copy(to_time, 1, poz - 1));
  Delete(to_time, 1, poz);
  minuteS := Trim(to_time);
  hour := StrToInt(hourS);
  minute := (hour * 60) + StrToInt(minuteS);
  end_time := minute * minute_width;
  width_pos := end_time - left;

  new_object.Left := left;
  new_object.Width := width_pos;

  new_shape := TShape.Create(Self);
  new_shape.Parent := new_object;
  new_shape.Align := alClient;
  new_shape.Brush.Color := canvas_color;

  new_label := TLabel.Create(Self);
  new_label.Parent := new_object;
  new_label.Top := 2;
  new_label.Left := 4;
  new_label.AutoSize := False;
  new_label.Height := new_shape.Height - 4;
  new_label.Width := new_shape.Width - 10;
  new_label.Caption := memo;
  new_label.Font.Color := text_color;
  new_label.Font.Style := [fsBold];
  new_label.StyleElements := [];
  new_label.Transparent := True;
end;

procedure TMainFrm.MyScrollVert(Sender: TObject);
begin
  box_left.VertScrollBar.Position := box_main.VertScrollBar.Position;
end;

procedure TMainFrm.MyScrollVert2(Sender: TObject);
begin
  box_main.VertScrollBar.Position := box_left.VertScrollBar.Position;
end;

procedure TMainFrm.ShowVisilbeRecords;
var
  i: Integer;
  count: Integer;
  height: Integer;
begin
  count := 0;
  for i := 1 to ile_max_rekordow do
  begin
    if tab_rec[i].Visible then
    begin
      tab_rec[i].Top := 3 + ((count + 1) * (pnl_height * 2)) - ((count + 1) * 2);
      tab_rec_name[i].Top := 3 + ((count + 1) * (pnl_height * 2)) - ((count + 1) * 2);
      Inc(count);
      pnl_pom.Top := 1;
      pnl_pom.Left := tab_rec_name[i].left + tab_rec_name[i].Width + 2;
      pnl_pom.Width := 1;
      pnl_pom.Height := 1;
    end
    else
    begin
      tab_rec[i].height := 0;
      tab_rec[i].Align := alTop;
    end;
  end;
  height := (count * (pnl_height * 2)) - (count * 2) + 4;
  pointer_line.Height := height;
end;

procedure TMainFrm.CreateRecords;
var
  i: Integer;
begin
  for i := 1 to ile_max_rekordow do
  begin
    tab_rec[i] := TPanel.Create(nil);
    tab_rec[i].height := pnl_height * 2;
    tab_rec[i].Parent := box_main;
    tab_rec[i].Anchors := [akLeft, akTop, akRight];
    tab_rec[i].Top := 3 + (i * (pnl_height * 2)) - (i * 2);
    tab_rec[i].BevelKind := bkFlat;
    tab_rec[i].BevelOuter := bvNone;
    tab_rec[i].left := 2;
    tab_rec[i].Width := pnl_width * 24;
    tab_rec[i].SendToBack;
    tab_rec[i].StyleElements := [seFont, seBorder];
    tab_rec[i].OnClick := def_panelClick;

    tab_rec_name[i] := TPanel.Create(nil);
    tab_rec_name[i].height := pnl_height * 2;
    tab_rec_name[i].Width := pnl_left.Width; // - 23;
    tab_rec_name[i].Parent := box_left;
    tab_rec_name[i].Anchors := [akLeft, akTop, akRight];
    tab_rec_name[i].Top := 3 + (i * (pnl_height * 2)) - (i * 2);
    tab_rec_name[i].BevelKind := bkFlat;
    tab_rec_name[i].BevelOuter := bvNone;
    tab_rec_name[i].Caption := 'pnl: ' + IntToStr(i);

   //Some record for example
    {if i = 1 then
      tab_rec_name[i].Caption := 'Waiting';
    if i = 2 then
      tab_rec_name[i].Caption := 'Task 1';
    if i = 3 then
      tab_rec_name[i].Caption := 'Home project';
    if i = 4 then
      tab_rec_name[i].Caption := 'Task 2';
    if i = 5 then
      tab_rec_name[i].Caption := 'Company project';
    if i = 6 then
      tab_rec_name[i].Caption := 'Other';}

    tab_rec_name[i].Font.Style := [fsBold];
    tab_rec_name[i].StyleElements := [seFont, seBorder];
    tab_rec_name[i].OnClick := def_panel_nameClick;

    tab_rec[i].Visible := False;
    tab_rec_name[i].Visible := False;

    {if i < 7 then
    begin
      tab_rec[i].Visible := True;
      tab_rec_name[i].Visible := True;
    end;}

  end;

  pnl_pom := TPanel.Create(Application);
  pnl_pom.Parent := box_left;
  pnl_pom.Width := pnl_width * 24;
  pnl_pom.Height := 23;
  pnl_pom.Left := 2;
  pnl_pom.Top := tab_rec_name[ile_max_rekordow].Top + tab_rec_name[ile_max_rekordow].height;

  pointer_line.Top := pnl_pointer.Top + pnl_pointer.Height;
  pointer_line.Width := 3;
  pointer_line.Height := box_main.Height;
  pointer_line.Parent := box_main;
  pointer_line.BevelKind := bkNone;
end;

procedure TMainFrm.def_panelClick(Sender: TObject);
var
  panel: TPanel;
  i: Integer;
begin
  panel := TPanel(Sender);
  for i := 1 to ile_max_rekordow do
  begin
    if tab_rec[i] = panel then
    begin
      tab_rec_name[i].Color := $00D5FFFF;
      tab_rec[i].Color := $00D5FFFF;
    end
    else
    begin
      tab_rec_name[i].Color := def_panel.Color;
      tab_rec[i].Color := def_panel.Color;
    end;
  end;
end;

procedure TMainFrm.def_panel_nameClick(Sender: TObject);
var
  panel: TPanel;
  i: Integer;
begin
  panel := TPanel(Sender);
  for i := 1 to ile_max_rekordow do
  begin
    if tab_rec_name[i] = panel then
    begin
      tab_rec_name[i].Color := $00D5FFFF;
      tab_rec[i].Color := $00D5FFFF;
    end
    else
    begin
      tab_rec_name[i].Color := def_panel.Color;
      tab_rec[i].Color := def_panel.Color;
    end;
  end;
end;

procedure TMainFrm.display_dateChange(Sender: TObject);
begin
  // ChangeDate;

  //CreateRecords;
  //ShowVisilbeRecords;

  ClearAllObjects;
  ChangeDate;
  //CreateHourPanels;
  CreateAllObjectsOnDate;
end;

procedure TMainFrm.box_leftResize(Sender: TObject);
begin
  pnl_pom.Left := tab_rec_name[1].left + tab_rec_name[1].Width + 2;
end;

procedure TMainFrm.btn_minusClick(Sender: TObject);
begin
  if pnl_width > 60 then
  begin
    box_main.HorzScrollBar.Position := 0;
    pnl_width := ((pnl_width div 60) - 1) * 60;
    ChangeHourWidth;
    ClearAllObjects;
    CreateAllObjectsOnDate;
  end;
end;

procedure TMainFrm.btn_plusClick(Sender: TObject);
begin
  if pnl_width < 600 then
  begin
    box_main.HorzScrollBar.Position := 0;
    pnl_width := ((pnl_width div 60) + 1) * 60;
    ChangeHourWidth;
    ClearAllObjects;
    CreateAllObjectsOnDate;
  end;
end;

procedure TMainFrm.ChangeDate;
var
  i: Integer;
  hour: string;
begin
  for i := 0 to 23 do
  begin
    hour := IntToStr(i);
    if Length(hour) = 1 then
      hour := '0' + hour;
    tab_hours[i].Caption := DateToStr(display_date.Date) + ' ' + hour + ' : xx';
  end;
end;

procedure TMainFrm.ChangeHourWidth;
var
  i: Integer;
  hour: string;
  x: Integer;
  w: Integer;
  graduation: TShape;
  description: TLabel;
  c: Integer;
begin
  for i := 0 to 23 do
  begin
    tab_hours[i].Width := pnl_width;
    tab_hours[i].left := i * pnl_width + 2;

    tab_minuts[i].Width := pnl_width;
    tab_minuts[i].left := i * pnl_width + 2;

    for c := tab_minuts[i].ControlCount - 1 downto 0 do
    begin
      tab_minuts[i].Controls[c].Destroy;
    end;

    w := pnl_width div 57;
    minute_width := w;
    for x := 1 to 60 do
    begin
      graduation := TShape.Create(Self);
      graduation.Parent := tab_minuts[i];
      graduation.Width := 1;
      graduation.Height := pnl_height div 5;
      graduation.Top := tab_minuts[i].height - graduation.Height - (graduation.Height div 2);
      graduation.Left := (x) * w;
      if (x mod 5) = 0 then
      begin
        graduation.Height := graduation.Height + 10;
        graduation.Top := graduation.Top - 10;
      end;
      if (x mod 15 = 0) and (x <> 60) then
      begin
        description := TLabel.Create(Self);
        description.Parent := tab_minuts[i];
        description.Caption := IntToStr(x);
        description.Top := -2;
        description.Left := ((x) * w + 2);
      end;
    end;
  end;

  for i := 1 to ile_max_rekordow do
    tab_rec[i].Width := pnl_width * 24;
end;

procedure TMainFrm.CreateHourPanels;
var
  i: Integer;
  hour: string;
  x: Integer;
  w: Integer;
  graduation: TShape;
  description: TLabel;
  panel_name: TPanel;
  panel_pom: TPanel;
begin
  panel_name := TPanel.Create(nil);
  panel_name.Parent := box_left;
  panel_name.Height := pnl_height;
  panel_name.Width := pnl_left.Width; // - 23;
  panel_name.Anchors := [akLeft, akTop, akRight];
  panel_name.BevelKind := bkFlat;
  panel_name.BevelOuter := bvNone;
  panel_name.Caption := 'Cronograma: PCP/OS';
  panel_name.Font.Style := [fsBold];

  panel_pom := TPanel.Create(nil);
  panel_pom.Parent := box_left;
  panel_pom.Height := pnl_height;
  panel_pom.Width := pnl_left.Width; // - 23;
  panel_pom.Anchors := [akLeft, akTop, akRight];
  panel_pom.BevelKind := bkFlat;
  panel_pom.BevelOuter := bvNone;
  panel_pom.Top := panel_name.Top + pnl_height - 1;

  for i := 0 to 23 do
  begin
    tab_hours[i] := TPanel.Create(Self);
    tab_hours[i].Parent := box_main;
    tab_hours[i].BevelKind := bkFlat;
    tab_hours[i].BevelOuter := bvNone;
    tab_hours[i].height := pnl_height;
    tab_hours[i].Width := pnl_width;
    tab_hours[i].left := i * pnl_width + 2;
    tab_hours[i].Top := 1;
    hour := IntToStr(i);
    if Length(hour) = 1 then
      hour := '0' + hour;
    tab_hours[i].Caption := DateToStr(display_date.Date) + ' ' + hour + ' : xx';
    tab_hours[i].Font.Style := [fsBold];

    tab_minuts[i] := TPanel.Create(Self);
    tab_minuts[i].Parent := box_main;
    tab_minuts[i].BevelKind := bkFlat;
    tab_minuts[i].BevelOuter := bvNone;
    tab_minuts[i].height := pnl_height;
    tab_minuts[i].Width := pnl_width;
    tab_minuts[i].left := i * pnl_width + 2;
    tab_minuts[i].Top := tab_hours[i].Top + pnl_height - 1;

    w := pnl_width div 57;
    minute_width := w;
    for x := 1 to 60 do
    begin
      graduation := TShape.Create(Self);
      graduation.Parent := tab_minuts[i];
      graduation.Width := 1;
      graduation.Height := pnl_height div 5;
      graduation.Top := tab_minuts[i].height - graduation.Height - (graduation.Height div 2);
      graduation.Left := (x) * w;
      if (x mod 5) = 0 then
      begin
        graduation.Height := graduation.Height + 10;
        graduation.Top := graduation.Top - 10;
      end;
      if (x mod 15 = 0) and (x <> 60) then
      begin
        description := TLabel.Create(Self);
        description.Parent := tab_minuts[i];
        description.Caption := IntToStr(x);
        description.Top := -2;
        description.Left := ((x) * w + 2);
      end;
    end;
  end;

  pnl_pointer := TPanel.Create(nil);
  pnl_pointer.Parent := box_main;
  pnl_pointer.Width := 20;
  pnl_pointer.Height := 20;
  pnl_pointer.Top := pnl_height + pnl_height - pnl_pointer.Height;
  pointer.Parent := pnl_pointer;
  pointer.Top := 1;
  pointer.Left := 1;
end;

procedure TMainFrm.FormCreate(Sender: TObject);
begin
  display_date.Date := Date;
  pnl_height := 30;
  pnl_width := 300;
  box_main.OnScrollVert := MyScrollVert;
  box_left.OnScrollVert := MyScrollVert2;
  CreateHourPanels;
  CreateRecords;
  ShowVisilbeRecords;
  CreateAllObjectsOnDate;
end;

procedure TMainFrm.FormResize(Sender: TObject);
begin
  ChangeHourWidth;
  ClearAllObjects;
  CreateAllObjectsOnDate;
end;

procedure TMainFrm.MouseTimerTimer(Sender: TObject);
var
  P: TPoint;
  position: Integer;
  position_from_start: Integer;
  hour: Integer;
  hourS: string;
  minuteS: string;
begin
  GetCursorPos(P);
  P := MainFrm.ScreenToClient(P);
  if (P.X >= (pnl_left.Width + Splitter1.Width + (pnl_pointer.Width div 2) + 5)) and (P.X <= MainFrm.Width - 30 - pnl_right.Width) and (P.Y > 0) and (P.Y <= MainFrm.Height - 100) then
  begin
    StatusBar1.Panels[1].Text := IntToStr(P.X) + ':' + IntToStr(P.Y);
    pnl_pointer.Left := P.X - (pnl_left.Width + Splitter1.Width) - (pnl_pointer.Width div 2);
    pointer_line.Left := P.X - (pnl_left.Width + Splitter1.Width) + 2;
    pointer_line.BringToFront;

    position := box_main.HorzScrollBar.Position + (P.X - (pnl_left.Width + Splitter1.Width) - (pnl_pointer.Width div 2));

    position_from_start := (((position) * 1440) div tab_rec[1].Width);
    hour := position_from_start div 60;
    position_from_start := position_from_start - (hour * 60);

    hourS := IntToStr(hour);
    if Length(hourS) = 1 then
      hourS := '0' + hourS;
    minuteS := IntToSTr(position_from_start);
    if Length(minuteS) = 1 then
      minuteS := '0' + minuteS;

    StatusBar1.Panels[2].Text := DateToStr(display_date.Date) + ' ' + hourS + ':' + minuteS;
  end;
end;

end.


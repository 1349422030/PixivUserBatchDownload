'*************************************
' ���������ڽ�Pվ��ʦ������Ʒ�������ع����ϰ汾Ĭ��Ŀ¼ת��Ϊ
' v3.0������ӵ��Զ����ļ��й�����Ҫ��Ŀ¼
' 
' https://github.com/Mapaler/PixivUserBatchDownload
'*************************************
Dim downDir
Set ws = CreateObject("WScript.Shell")
set fs = CreateObject("Scripting.FileSystemObject")

If InStr(WScript.FullName,"wscript.exe") Then
	Set ws = CreateObject("WScript.Shell")
	ws.Run "cscript.exe """ & WScript.ScriptFullName & """ """ & WScript.Arguments(0) & """"
	WScript.Quit
End If

If WScript.Arguments.Count>0 Then
	downDir = WScript.Arguments(0)
End If
If Not fs.FolderExists(downDir) Then
	downDir = InputBox("����PվͼƬ���ظ�Ŀ¼���������û������ļ��С�" & vbCrLf & vbCrLf & "��ʱ���п��ܻ�ִ��ʧ�ܣ���ೢ�Լ��Σ�ֱ����ʾ��������ɡ���","·���������Ľű�")
End If
If Not fs.FolderExists(downDir) Then
	WScript.Echo "ͼƬĿ¼������"
	WScript.Quit
End If


Set root = fs.GetFolder(downDir)
Dim numName
For each user in root.SubFolders
	WScript.Echo "���ڴ��� " & user.Name
	Set inuser = isCutPath(user)
	For each muilt in inuser.SubFolders
		Set inmuilt = isCutPath(muilt)
		For each file in inmuilt.Files
			'WScript.Echo file.Name & " move to " & user.Path
			file.Move user.Path & "\" & file.Name
		Next
		'WScript.Echo "Delete " & muilt.Path
		muilt.Delete
	Next
	If user.Path <> inuser.Path Then
		'WScript.Echo "Delete " & inuser.Path
		inuser.Delete
	End If
	numName = Split(user.Name,"_")
	If Not fs.FolderExists(root.Path & "\" & numName(0)) Then
		user.Move root.Path & "\" & numName(0)
	End If
Next

Function isCutPath(folder)
	If folder.SubFolders.Count = 1 And folder.Files.Count = 0 Then
		For each fol in folder.SubFolders
			Set isCutPath = isCutPath(fol)
		Next
	Else
		Set isCutPath = folder
	End If
End Function

MsgBox "�������"
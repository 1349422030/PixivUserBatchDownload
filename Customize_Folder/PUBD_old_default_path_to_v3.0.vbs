'*************************************
' ���������ڽ�Pվ��ʦ������Ʒ�������ع����ϰ汾Ĭ��Ŀ¼ת��Ϊ
' v3.0������ӵ��Զ����ļ��й�����Ҫ��Ŀ¼
' 
' https://github.com/Mapaler/PixivUserBatchDownload
'*************************************
Dim downDir
If WScript.Arguments.Count>1 Then
	downDir = WScript.Arguments(0)
End If
If Not fso.FolderExists(downDir) Then
	downDir = InputBox("����PվͼƬ���ظ�Ŀ¼���������û������ļ��С�","�Զ����ļ��нű�")
End If
If Not fso.FolderExists(downDir) Then
	WScript.Echo "ͼƬĿ¼������"
	WScript.Quit
End If

Set ws = CreateObject("WScript.Shell")
set fs = CreateObject("Scripting.FileSystemObject")

Set root = fs.GetFolder("k:\Image\Pվ\")
For each user in root.SubFolders
	WScript.Echo "���ڴ��� " & user.Name
	Set inuser = isCutPath(user)
	For each muilt in inuser.SubFolders
		Set inmuilt = isCutPath(muilt)
		For each file in inmuilt.Files
			'WScript.Echo file.Name & " move to " & inuser.Path
			file.Move inuser.Path & "\" & file.Name
		Next
		'WScript.Echo "Delete " & muilt.Path
		muilt.Delete
	Next
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
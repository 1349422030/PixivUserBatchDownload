'*************************************
' ����������Pվ��ʦ������Ʒ�������ع���v3.0������ӵ��Զ����ļ��й���
' 
' https://github.com/Mapaler/PixivUserBatchDownload
'*************************************
Dim downDir
downDir = "" 'Ĭ�ϵ�����Ŀ¼
p_ncvt = "nconvert.exe" 'NConvert����·��

Dim ws,fso
Set ws = CreateObject("WScript.Shell")
set fso = CreateObject("Scripting.FileSystemObject")

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

Const FILE_ATTRIBUTE_READONLY=1 'ֻ��
Const FILE_ATTRIBUTE_HIDDEN=2 '����
Const FILE_ATTRIBUTE_SYSTEM=4 'ϵͳ
Const FILE_ATTRIBUTE_DIRECTORY=16 'Ŀ¼
Const FILE_ATTRIBUTE_ARCHIVE=32 '�浵
Const FILE_ATTRIBUTE_DEVICE=64 '����
Const FILE_ATTRIBUTE_NORMAL=128 '����
Const FILE_ATTRIBUTE_TEMPORARY=256 '��ʱ
Const FILE_ATTRIBUTE_SPARSE_FILE=512 'ϡ���ļ�
Const FILE_ATTRIBUTE_REPARSE_POINT=1024 '�����ӻ��ݷ�ʽ
Const FILE_ATTRIBUTE_COMPRESSED=2048 'ѹ��
Const FILE_ATTRIBUTE_OFFLINE=4096 '�ѻ�
Const FILE_ATTRIBUTE_NOT_CONTENT_INDEXED=8192 '����
Const FILE_ATTRIBUTE_ENCRYPTED=16384 '����
Const FILE_ATTRIBUTE_VIRTUAL=65536 '����

Set root = fso.GetFolder(downDir)
Dim cstFolder
For each user in root.SubFolders
	cstFolder = False
	'oldAttributes = user.Attributes
	For each file in user.Files
		If fso.GetExtensionName(file) = "torrent" Then
			If fso.FileExists(user.Path & "\Desktop.ini") Then fso.DeleteFile(user.Path & "\Desktop.ini")
			file.Move user.Path & "\Desktop.ini"
			file.Attributes = FILE_ATTRIBUTE_HIDDEN Or FILE_ATTRIBUTE_SYSTEM Or FILE_ATTRIBUTE_ARCHIVE
			cstFolder = True
		ElseIf file.name = "head.image" Then
			'ת��ʽ��������
			command = """" & p_ncvt & """ -resize 256 256 -out ico -q -truecolors "
			command = command & " -D" 'ɾ��ԭʼ�ļ�
			command = command & " -overwrite" '���Ǵ����ļ�
			command = command & " """ & file.Path & """"
			Set oExec = ws.Exec(command)
			strErr = oExec.StdErr.ReadAll() '������Ϊ�˱�����ɺ��ټ���
			Set icofile = fso.GetFile(user.Path & "\head.ico")
			icofile.Attributes = FILE_ATTRIBUTE_HIDDEN Or FILE_ATTRIBUTE_SYSTEM Or FILE_ATTRIBUTE_ARCHIVE
			If fso.FileExists(user.Path & "\head.image") Then fso.DeleteFile(user.Path & "\head.image")
		End If
	Next
	If cstFolder Then
		user.Attributes = FILE_ATTRIBUTE_READONLY Or FILE_ATTRIBUTE_DIRECTORY
		'user.Attributes = oldAttributes
	End If
Next
WScript.Echo "����ִ�����"
Set ws = CreateObject("WScript.Shell")
set fs = CreateObject("Scripting.FileSystemObject")

p_ncvt = "nconvert.exe" 'NConvert����·��

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

Set root = fs.GetFolder("f:\PivixDownload - ����\")
For each user in root.SubFolders
	oldAttributes = user.Attributes
	For each file in user.Files
		If fs.GetExtensionName(file) = "torrent" Then
			file.Move file.ParentFolder & "\Desktop.ini"
			file.Attributes = FILE_ATTRIBUTE_HIDDEN Or FILE_ATTRIBUTE_SYSTEM Or FILE_ATTRIBUTE_ARCHIVE
		ElseIf file.name = "head.image" Then
			'ת��ʽ��������
			command = """" & p_ncvt & """ -resize 256 256 -out ico -q -truecolors "
			command = command & " -D" 'ɾ��ԭʼ�ļ�
			command = command & " -overwrite" '���Ǵ����ļ�
			command = command & " """ & file.Path & """"
			Set oExec = ws.Exec(command)
			strErr = oExec.StdErr.ReadAll() '������Ϊ�˱�����ɺ��ټ���
			Set icofile = fs.GetFile(file.ParentFolder & "\head.ico")
			icofile.Attributes = FILE_ATTRIBUTE_HIDDEN Or FILE_ATTRIBUTE_SYSTEM Or FILE_ATTRIBUTE_ARCHIVE
		End If
	Next
	user.Attributes = FILE_ATTRIBUTE_READONLY Or FILE_ATTRIBUTE_DIRECTORY Or FILE_ATTRIBUTE_HIDDEN Or FILE_ATTRIBUTE_SYSTEM
	user.Attributes = FILE_ATTRIBUTE_READONLY Or FILE_ATTRIBUTE_DIRECTORY
Next
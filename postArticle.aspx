<%@ Page Language="C#" AutoEventWireup="true" CodeFile="postArticle.aspx.cs" Inherits="postArticle" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script src="https://cdn.ckeditor.com/4.14.1/standard/ckeditor.js"></script>
    <style>
        .article {
            margin: 5px 10px 1.5em 60px;
            border-color: black;
        }
        .name {
            margin: auto auto 1em auto;
        }
        .head{
            height:1em;
            margin:1em auto 1.5em 30px;
        }
    </style>
    <script>
        function buttonclick() {
            var temp = CKEDITOR.instances.editor1.getData();
            var author = document.getElementById("TextBox2")
            if (temp != "") {
                document.getElementById("article").value = CKEDITOR.tools.htmlEncode(temp);
                CKEDITOR.instances.editor1.setData('');
                document.getElementById("send").click();
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div class="head">
                <a href="Default.aspx">返回首頁</a>
            </div>
            <div class="article">
                <div class="name">
                    <span>名稱</span>
                    <asp:TextBox ID="TextBox1" runat="server" placeholder="遊客"></asp:TextBox>
                </div>
                <div class="name">
                    <span>標題</span>
                    <asp:TextBox ID="TextBox2" runat="server" placeholder="無標題" ></asp:TextBox>
                </div>
                <textarea id="editor1" runat="server"></textarea><br />
                <script>
                    CKEDITOR.replace('editor1', {
                        width: '70%',
                        htmlEncodeOutput: true,
                    });
                </script>
                <input id="Button1" type="button" value="發布文章" onclick="buttonclick()" />
            </div>

            <asp:Button ID="send" runat="server" Text="Button" Style="display: none;" OnClick="Button1_Click" />
            <asp:HiddenField ID="article" runat="server" />
            <asp:HiddenField ID="articleID" runat="server" />
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:ConnectionString %>' DeleteCommand="DELETE FROM [title] WHERE [Id] = @Id" SelectCommand="SELECT [Id] FROM [title]" InsertCommand="INSERT INTO title(title, author) VALUES (@title, @author)">
                <DeleteParameters>
                    <asp:Parameter Name="Id" Type="Int32"></asp:Parameter>
                </DeleteParameters>
                <InsertParameters>
                    <asp:ControlParameter ControlID="TextBox2" Name="title" PropertyName="Text" DefaultValue="無標題" />
                    <asp:ControlParameter ControlID="TextBox1" Name="author" PropertyName="Text" DefaultValue="遊客" />
                </InsertParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString='<%$ ConnectionStrings:ConnectionString %>' DeleteCommand="DELETE FROM [article] WHERE [Id] = @Id" InsertCommand="INSERT INTO article(author, story, titleID) VALUES (@author, @article, @titleID)" SelectCommand="SELECT * FROM [article]">
                <DeleteParameters>
                    <asp:Parameter Name="Id" Type="Int32"></asp:Parameter>
                </DeleteParameters>
                <InsertParameters>
                    <asp:ControlParameter ControlID="article" Name="article" PropertyName="Value" />
                    <asp:ControlParameter ControlID="articleID" Name="titleID" PropertyName="Value" />
                    <asp:ControlParameter ControlID="TextBox1" Name="author" PropertyName="Text" DefaultValue="遊客" />
                </InsertParameters>
            </asp:SqlDataSource>
        </div>
    </form>
</body>
</html>

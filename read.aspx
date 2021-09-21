<%@ Page Language="C#" AutoEventWireup="true" CodeFile="read.aspx.cs" Inherits="_Default" ValidateRequest="false" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="https://cdn.ckeditor.com/4.14.1/standard/ckeditor.js"></script>
    <title></title>
    <style>
        .article {
            margin: 5px 10px 1.5em 60px;
            border-color: black;
            width:60%;
        }

        .title {
            margin: 1em 10px 1em 30px;
            font-size: 24px;
            font-weight: bold;
            align-items: center;
        }

        .story {
            border: 1px solid gray;
            background-color: navajowhite;
        }

        .name {
            margin: auto auto 1em auto;
        }
        .head{
            height:1em;
            margin:2em auto auto 30px;
        }
    </style>
    <script>
        function buttonclick() {
            var temp = CKEDITOR.instances.editor1.getData();
            document.getElementById("HiddenField1").value = CKEDITOR.tools.htmlEncode(temp);
            CKEDITOR.instances.editor1.setData('');
            document.getElementById("send").click();

        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div class="head">
                <a href="Default.aspx">返回首頁</a>
            </div>
            <div class="title">
                <asp:FormView ID="FormView1" runat="server" DataSourceID="SqlDataSource2">
                    <ItemTemplate>
                        <asp:Label Text='<%# Bind("title") %>' runat="server" ID="titleText" /><br />
                        <%--<asp:Label ID="titleText" runat="server" Text="大家今天晚餐吃什麼?"></asp:Label>--%>
                    </ItemTemplate>
                </asp:FormView>
            </div>

            <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
                <ItemTemplate>
                    <div class="article">
                        <div style="height: 20px;">
                            <asp:Label ID="Label1" Style="width: 150px; display: inline-block" runat="server" Text='<%# Bind("author") %>'></asp:Label>
                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("time") %>'></asp:Label>
                        </div>
                        <div class="story">
                            <%# System.Web.HttpUtility.HtmlDecode(Eval("story").ToString())%>
                        </div>
                    </div>

                </ItemTemplate>
            </asp:Repeater>
            <hr style="                    color: gray;
                    width: 80%;
                    margin: 3em auto;
            " />


            <%--            <div class="article">
                <div style="display: inline-block; height: 30px;">
                    <asp:Label ID="Label1" Style="width: 100px; display: inline-block"
                        runat="server" Text="遊客"></asp:Label>
                    <asp:Label ID="Label3" runat="server" Text="2019/08/23 17:8:5"></asp:Label>
                </div>
                <div>
                    <asp:Label ID="Label2" runat="server" Text="今天吃咖哩 \r\n sdfqwrew"></asp:Label>
                    <br />
                    <asp:Label ID="Label4" runat="server" Text="今天吃咖哩 \r\n sdfqwrew"></asp:Label>
                    <br />
                    <asp:Label ID="Label10" runat="server" Text="今天吃咖哩 \r\n sdfqwrew"></asp:Label>
                    <br />
                    <asp:Label ID="Label11" runat="server" Text="今天吃咖哩 \r\n <br />sdfqwrew"></asp:Label>
                    <br />

                </div>
            </div>
            <div class="article">
                <div style="display: inline-block; height: 30px;">
                    <asp:Label ID="Label5" Style="width: 100px; display: inline-block" runat="server" Text="遊客"></asp:Label>
                    <asp:Label ID="Label6" runat="server" Text="2019/08/23 17:8:5"></asp:Label>
                </div>
                <div>
                    <asp:Label ID="Label7" runat="server" Text="今天吃咖哩 \r\n sdfqsdfssssssssssswrew"></asp:Label>
                    <br />
                    <asp:Label ID="Label8" runat="server" Text="今天吃咖哩 \r\n sdfqwrew"></asp:Label>
                    <br />
                    <asp:Label ID="Label9" runat="server" Text="今天吃咖哩 \r\n sdfqwrew"></asp:Label>
                    <br />

                </div>
            </div>--%>

            <div class="article">
                <div class="name">
                    <span>名稱</span>
                    <asp:TextBox ID="TextBox1" runat="server" placeholder="遊客"></asp:TextBox>
                </div>
                <textarea id="editor1" runat="server"></textarea><br />
                <script>
                    CKEDITOR.replace('editor1', {
                        width: '70%',
                        htmlEncodeOutput: true,
                    });
                </script>
                <input id="Button1" type="button" value="送出回應" onclick="buttonclick()" />
            </div>

            <asp:HiddenField ID="HiddenField1" runat="server" />
            <asp:Button ID="send" runat="server" Text="Button" Style="display: none;" OnClick="Button1_Click" />
            <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:ConnectionString %>' SelectCommand="SELECT [author], [story], [time] FROM [article] WHERE [titleID]=@id" InsertCommand="INSERT INTO article(author, story, titleID) VALUES (@author, @story, @id)" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>">
                <InsertParameters>
                    <asp:ControlParameter ControlID="TextBox1" Name="author" PropertyName="Text" DefaultValue="遊客" />
                    <asp:ControlParameter ControlID="HiddenField1" Name="story" PropertyName="Value" />
                    <asp:QueryStringParameter Name="id" QueryStringField="id" />
                </InsertParameters>
                <SelectParameters>
                    <asp:QueryStringParameter Name="id" QueryStringField="id" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString='<%$ ConnectionStrings:ConnectionString %>' SelectCommand="SELECT [title] FROM [title] WHERE ([Id] = @Id)">
                <SelectParameters>
                    <asp:QueryStringParameter QueryStringField="id" Name="Id" Type="Int32"></asp:QueryStringParameter>
                </SelectParameters>
            </asp:SqlDataSource>

        </div>
    </form>
</body>
</html>

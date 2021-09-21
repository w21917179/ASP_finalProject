<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <style>
        .grid {
            margin: 2em auto auto 2em;
            width: 60%;
        }

        .article {
            margin: 5px 10px 1.5em 120px;
            border-color: black;
            width:60%;
        }

            .article.box1 {
                margin: 5px 10px 3em 60px;
            }

        .story {
            border: 1px solid gray;
            background-color: navajowhite;
        }

        .title {
            margin: 1em 10px 1em 30px;
            font-size: 24px;
            font-weight: bold;
            align-items: center;
        }

        .head{
            height:3em;
            margin:auto auto auto 30px;
        }
        .head.button{
            font-size:20px;
            height:1.5em;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="head"> 
            <asp:Button class="head button" ID="Button1" runat="server" Text="發廢文"  OnClick="Button1_Click"/>
        </div>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:ConnectionString %>' SelectCommand="SELECT * FROM [title] ORDER BY time DESC"></asp:SqlDataSource>
        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
            <ItemTemplate>
                <div class="repeater">
                    <asp:HiddenField ID="HiddenField1" Value='<%# Eval("Id") %>' runat="server" />
                    <asp:Label class="title" Text='<%# Eval("title") %>' runat="server" ID="IdLabel" />
                    <asp:HyperLink runat="server" Text="查看全文" NavigateUrl='<%# Eval("id", "read.aspx?id={0}") %>' ID="HyperLink1"></asp:HyperLink>
                    <br />
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString='<%$ ConnectionStrings:ConnectionString %>' SelectCommand="SELECT Id, author, story, time, titleID FROM (SELECT TOP (3) Id, author, story, time, titleID FROM article WHERE (titleID = @titleID) ORDER BY time DESC UNION SELECT TOP (1) Id, author, story, time, titleID FROM article AS article_1 WHERE (titleID = @titleID) ORDER BY time) AS derivedtbl_1 ORDER BY time">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="HiddenField1" PropertyName="Value" Name="titleID" Type="Int32"></asp:ControlParameter>
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlDataSource2">
                        <ItemTemplate>
                            <div class="article box<%# Container.ItemIndex + 1 %>">
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


                </div>
                <hr / style="color:gray; height:1px;">
            </ItemTemplate>
        </asp:Repeater>





























        <%--        <div>
            <asp:GridView class="grid" ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSource1">
                <Columns>
                    <asp:BoundField DataField="title" HeaderText="標題" SortExpression="title">
                        <ItemStyle Width="40%"></ItemStyle>
                    </asp:BoundField>
                    <asp:BoundField DataField="author" HeaderText="作者" SortExpression="author">
                        <ItemStyle Width="12%"></ItemStyle>

                    </asp:BoundField>
                    <asp:BoundField DataField="time" HeaderText="發文時間" SortExpression="time"></asp:BoundField>
                    <asp:HyperLinkField DataNavigateUrlFormatString="read.aspx?id={0}" DataTextField="title" HeaderText="標題" DataNavigateUrlFields="id"></asp:HyperLinkField>
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:ConnectionString %>' SelectCommand="SELECT * FROM [title]"></asp:SqlDataSource>
        </div>--%>
    </form>
</body>
</html>

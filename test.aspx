<%@ Page Language="C#" AutoEventWireup="true" CodeFile="test.aspx.cs" Inherits="test" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <style>
        #divbox1 {
            border: 1px solid gray;
            background-color: navajowhite;
        }

        div.repeater {
            background-color: green;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSource1">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" SortExpression="Id"></asp:BoundField>
                    <asp:BoundField DataField="title" HeaderText="title" SortExpression="title"></asp:BoundField>
                    <asp:BoundField DataField="author" HeaderText="author" SortExpression="author"></asp:BoundField>
                    <asp:BoundField DataField="time" HeaderText="time" SortExpression="time"></asp:BoundField>
                    <asp:HyperLinkField></asp:HyperLinkField>
                    <asp:HyperLinkField DataNavigateUrlFields="id" DataNavigateUrlFormatString="read.aspx?id={0}" Text="查看全文"></asp:HyperLinkField>
                </Columns>
            </asp:GridView>
            <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
                <ItemTemplate>
                    <div class="repeater">
                        <asp:Label Text='<%# Eval("Id") %>' runat="server" ID="IdLabel" /><br />
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString='<%$ ConnectionStrings:ConnectionString %>' SelectCommand="SELECT Id, author, story, time, titleID FROM (SELECT TOP (4) Id, author, story, time, titleID FROM article WHERE (titleID = @titleID) ORDER BY time DESC) AS derivedtbl_1 ORDER BY time">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="IdLabel" PropertyName="Text" Name="titleID" Type="Int32"></asp:ControlParameter>
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlDataSource2">
                            <ItemTemplate>

                                <div id="divbox<%# Container.ItemIndex + 1 %>">
                                    Id:
                            <asp:Label Text='<%# Eval("Id") %>' runat="server" ID="IdLabel" /><br />
                                    author:
                            <asp:Label Text='<%# Bind("author") %>' runat="server" ID="authorLabel" /><br />
                                    story:
                            <asp:Label Text='<%# Bind("story") %>' runat="server" ID="storyLabel" /><br />
                                    time:
                            <asp:Label Text='<%# Bind("time") %>' runat="server" ID="timeLabel" /><br />
                                    titleID:
                            <asp:Label Text='<%# Bind("titleID") %>' runat="server" ID="titleIDLabel" /><br />
                                    <hr />
                                </div>

                            </ItemTemplate>
                        </asp:Repeater>








                    </div>


                </ItemTemplate>
            </asp:Repeater>

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:ConnectionString %>' SelectCommand="SELECT * FROM [title]"></asp:SqlDataSource>
        </div>
    </form>
</body>
</html>

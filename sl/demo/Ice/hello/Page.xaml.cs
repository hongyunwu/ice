﻿using System;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Ink;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Shapes;

using System.Net;
using System.IO;
using System.Collections;
using System.Text;
using System.Windows.Browser.Net;

namespace helloC
{
    public partial class Page : Canvas
    {
        private static TextBlock _tb;
        public void Page_Loaded(object o, EventArgs e)
        {
            // Required to initialize variables
            InitializeComponent();
            Button1.MouseLeftButtonUp += new MouseEventHandler(OnClick);
            
            _tb = Button2.Children[0] as TextBlock;
        }
        public Page()
        {
            //this.Loaded += new EventHandler(EventHandlingCanvas_Loaded);
        }

        void EventHandlingCanvas_Loaded(object sender, EventArgs e)
        { 
        }

        void OnClick(object sender, MouseEventArgs e)
        {
            try
            {
                Ice.InitializationData initData = new Ice.InitializationData();
                initData.properties = Ice.Util.createProperties();
                initData.properties.setProperty("Ice.BridgeUri", "http://localhost:1287/IceBridge.ashx");
                Ice.Communicator comm = Ice.Util.initialize(initData);
                Demo.HelloPrx hello = Demo.HelloPrxHelper.uncheckedCast(comm.stringToProxy("hello:tcp -p 10000"));
                hello.sayHello(0);
            }
            catch (Exception ex)
            {
                _tb.Text = ex.ToString();
                return;
            }
            _tb.Text = "Call Succeeded";
        }       
    }
}

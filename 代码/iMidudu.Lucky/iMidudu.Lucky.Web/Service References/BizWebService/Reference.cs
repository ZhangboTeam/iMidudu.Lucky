﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.0
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace iMidudu.Lucky.Web.BizWebService {
    using System.Runtime.Serialization;
    using System;
    
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Runtime.Serialization", "4.0.0.0")]
    [System.Runtime.Serialization.DataContractAttribute(Name="WXUser", Namespace="http://tempuri.org/")]
    [System.SerializableAttribute()]
    public partial class WXUser : object, System.Runtime.Serialization.IExtensibleDataObject, System.ComponentModel.INotifyPropertyChanged {
        
        [System.NonSerializedAttribute()]
        private System.Runtime.Serialization.ExtensionDataObject extensionDataField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string OpenIdField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string NickNameField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string PicField;
        
        private bool SexField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string WXCityField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string WXProvinceField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string WXCountryField;
        
        private System.DateTime RegisterDateField;
        
        private System.DateTime LastActiveTimeField;
        
        [global::System.ComponentModel.BrowsableAttribute(false)]
        public System.Runtime.Serialization.ExtensionDataObject ExtensionData {
            get {
                return this.extensionDataField;
            }
            set {
                this.extensionDataField = value;
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute(EmitDefaultValue=false)]
        public string OpenId {
            get {
                return this.OpenIdField;
            }
            set {
                if ((object.ReferenceEquals(this.OpenIdField, value) != true)) {
                    this.OpenIdField = value;
                    this.RaisePropertyChanged("OpenId");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute(EmitDefaultValue=false, Order=1)]
        public string NickName {
            get {
                return this.NickNameField;
            }
            set {
                if ((object.ReferenceEquals(this.NickNameField, value) != true)) {
                    this.NickNameField = value;
                    this.RaisePropertyChanged("NickName");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute(EmitDefaultValue=false, Order=2)]
        public string Pic {
            get {
                return this.PicField;
            }
            set {
                if ((object.ReferenceEquals(this.PicField, value) != true)) {
                    this.PicField = value;
                    this.RaisePropertyChanged("Pic");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute(IsRequired=true, Order=3)]
        public bool Sex {
            get {
                return this.SexField;
            }
            set {
                if ((this.SexField.Equals(value) != true)) {
                    this.SexField = value;
                    this.RaisePropertyChanged("Sex");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute(EmitDefaultValue=false, Order=4)]
        public string WXCity {
            get {
                return this.WXCityField;
            }
            set {
                if ((object.ReferenceEquals(this.WXCityField, value) != true)) {
                    this.WXCityField = value;
                    this.RaisePropertyChanged("WXCity");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute(EmitDefaultValue=false, Order=5)]
        public string WXProvince {
            get {
                return this.WXProvinceField;
            }
            set {
                if ((object.ReferenceEquals(this.WXProvinceField, value) != true)) {
                    this.WXProvinceField = value;
                    this.RaisePropertyChanged("WXProvince");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute(EmitDefaultValue=false, Order=6)]
        public string WXCountry {
            get {
                return this.WXCountryField;
            }
            set {
                if ((object.ReferenceEquals(this.WXCountryField, value) != true)) {
                    this.WXCountryField = value;
                    this.RaisePropertyChanged("WXCountry");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute(IsRequired=true, Order=7)]
        public System.DateTime RegisterDate {
            get {
                return this.RegisterDateField;
            }
            set {
                if ((this.RegisterDateField.Equals(value) != true)) {
                    this.RegisterDateField = value;
                    this.RaisePropertyChanged("RegisterDate");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute(IsRequired=true, Order=8)]
        public System.DateTime LastActiveTime {
            get {
                return this.LastActiveTimeField;
            }
            set {
                if ((this.LastActiveTimeField.Equals(value) != true)) {
                    this.LastActiveTimeField = value;
                    this.RaisePropertyChanged("LastActiveTime");
                }
            }
        }
        
        public event System.ComponentModel.PropertyChangedEventHandler PropertyChanged;
        
        protected void RaisePropertyChanged(string propertyName) {
            System.ComponentModel.PropertyChangedEventHandler propertyChanged = this.PropertyChanged;
            if ((propertyChanged != null)) {
                propertyChanged(this, new System.ComponentModel.PropertyChangedEventArgs(propertyName));
            }
        }
    }
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ServiceModel.ServiceContractAttribute(ConfigurationName="BizWebService.BizWebServiceSoap")]
    public interface BizWebServiceSoap {
        
        // CODEGEN: Generating message contract since element name ActivityByCodeResult from namespace http://tempuri.org/ is not marked nillable
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/ActivityByCode", ReplyAction="*")]
        iMidudu.Lucky.Web.BizWebService.ActivityByCodeResponse ActivityByCode(iMidudu.Lucky.Web.BizWebService.ActivityByCodeRequest request);
        
        // CODEGEN: Generating message contract since element name user from namespace http://tempuri.org/ is not marked nillable
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/SaveWXUser", ReplyAction="*")]
        iMidudu.Lucky.Web.BizWebService.SaveWXUserResponse SaveWXUser(iMidudu.Lucky.Web.BizWebService.SaveWXUserRequest request);
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
    [System.ServiceModel.MessageContractAttribute(IsWrapped=false)]
    public partial class ActivityByCodeRequest {
        
        [System.ServiceModel.MessageBodyMemberAttribute(Name="ActivityByCode", Namespace="http://tempuri.org/", Order=0)]
        public iMidudu.Lucky.Web.BizWebService.ActivityByCodeRequestBody Body;
        
        public ActivityByCodeRequest() {
        }
        
        public ActivityByCodeRequest(iMidudu.Lucky.Web.BizWebService.ActivityByCodeRequestBody Body) {
            this.Body = Body;
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
    [System.Runtime.Serialization.DataContractAttribute(Namespace="http://tempuri.org/")]
    public partial class ActivityByCodeRequestBody {
        
        [System.Runtime.Serialization.DataMemberAttribute(Order=0)]
        public System.Guid Code;
        
        public ActivityByCodeRequestBody() {
        }
        
        public ActivityByCodeRequestBody(System.Guid Code) {
            this.Code = Code;
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
    [System.ServiceModel.MessageContractAttribute(IsWrapped=false)]
    public partial class ActivityByCodeResponse {
        
        [System.ServiceModel.MessageBodyMemberAttribute(Name="ActivityByCodeResponse", Namespace="http://tempuri.org/", Order=0)]
        public iMidudu.Lucky.Web.BizWebService.ActivityByCodeResponseBody Body;
        
        public ActivityByCodeResponse() {
        }
        
        public ActivityByCodeResponse(iMidudu.Lucky.Web.BizWebService.ActivityByCodeResponseBody Body) {
            this.Body = Body;
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
    [System.Runtime.Serialization.DataContractAttribute(Namespace="http://tempuri.org/")]
    public partial class ActivityByCodeResponseBody {
        
        [System.Runtime.Serialization.DataMemberAttribute(EmitDefaultValue=false, Order=0)]
        public string ActivityByCodeResult;
        
        public ActivityByCodeResponseBody() {
        }
        
        public ActivityByCodeResponseBody(string ActivityByCodeResult) {
            this.ActivityByCodeResult = ActivityByCodeResult;
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
    [System.ServiceModel.MessageContractAttribute(IsWrapped=false)]
    public partial class SaveWXUserRequest {
        
        [System.ServiceModel.MessageBodyMemberAttribute(Name="SaveWXUser", Namespace="http://tempuri.org/", Order=0)]
        public iMidudu.Lucky.Web.BizWebService.SaveWXUserRequestBody Body;
        
        public SaveWXUserRequest() {
        }
        
        public SaveWXUserRequest(iMidudu.Lucky.Web.BizWebService.SaveWXUserRequestBody Body) {
            this.Body = Body;
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
    [System.Runtime.Serialization.DataContractAttribute(Namespace="http://tempuri.org/")]
    public partial class SaveWXUserRequestBody {
        
        [System.Runtime.Serialization.DataMemberAttribute(EmitDefaultValue=false, Order=0)]
        public iMidudu.Lucky.Web.BizWebService.WXUser user;
        
        public SaveWXUserRequestBody() {
        }
        
        public SaveWXUserRequestBody(iMidudu.Lucky.Web.BizWebService.WXUser user) {
            this.user = user;
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
    [System.ServiceModel.MessageContractAttribute(IsWrapped=false)]
    public partial class SaveWXUserResponse {
        
        [System.ServiceModel.MessageBodyMemberAttribute(Name="SaveWXUserResponse", Namespace="http://tempuri.org/", Order=0)]
        public iMidudu.Lucky.Web.BizWebService.SaveWXUserResponseBody Body;
        
        public SaveWXUserResponse() {
        }
        
        public SaveWXUserResponse(iMidudu.Lucky.Web.BizWebService.SaveWXUserResponseBody Body) {
            this.Body = Body;
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
    [System.Runtime.Serialization.DataContractAttribute()]
    public partial class SaveWXUserResponseBody {
        
        public SaveWXUserResponseBody() {
        }
    }
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    public interface BizWebServiceSoapChannel : iMidudu.Lucky.Web.BizWebService.BizWebServiceSoap, System.ServiceModel.IClientChannel {
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    public partial class BizWebServiceSoapClient : System.ServiceModel.ClientBase<iMidudu.Lucky.Web.BizWebService.BizWebServiceSoap>, iMidudu.Lucky.Web.BizWebService.BizWebServiceSoap {
        
        public BizWebServiceSoapClient() {
        }
        
        public BizWebServiceSoapClient(string endpointConfigurationName) : 
                base(endpointConfigurationName) {
        }
        
        public BizWebServiceSoapClient(string endpointConfigurationName, string remoteAddress) : 
                base(endpointConfigurationName, remoteAddress) {
        }
        
        public BizWebServiceSoapClient(string endpointConfigurationName, System.ServiceModel.EndpointAddress remoteAddress) : 
                base(endpointConfigurationName, remoteAddress) {
        }
        
        public BizWebServiceSoapClient(System.ServiceModel.Channels.Binding binding, System.ServiceModel.EndpointAddress remoteAddress) : 
                base(binding, remoteAddress) {
        }
        
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
        iMidudu.Lucky.Web.BizWebService.ActivityByCodeResponse iMidudu.Lucky.Web.BizWebService.BizWebServiceSoap.ActivityByCode(iMidudu.Lucky.Web.BizWebService.ActivityByCodeRequest request) {
            return base.Channel.ActivityByCode(request);
        }
        
        public string ActivityByCode(System.Guid Code) {
            iMidudu.Lucky.Web.BizWebService.ActivityByCodeRequest inValue = new iMidudu.Lucky.Web.BizWebService.ActivityByCodeRequest();
            inValue.Body = new iMidudu.Lucky.Web.BizWebService.ActivityByCodeRequestBody();
            inValue.Body.Code = Code;
            iMidudu.Lucky.Web.BizWebService.ActivityByCodeResponse retVal = ((iMidudu.Lucky.Web.BizWebService.BizWebServiceSoap)(this)).ActivityByCode(inValue);
            return retVal.Body.ActivityByCodeResult;
        }
        
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
        iMidudu.Lucky.Web.BizWebService.SaveWXUserResponse iMidudu.Lucky.Web.BizWebService.BizWebServiceSoap.SaveWXUser(iMidudu.Lucky.Web.BizWebService.SaveWXUserRequest request) {
            return base.Channel.SaveWXUser(request);
        }
        
        public void SaveWXUser(iMidudu.Lucky.Web.BizWebService.WXUser user) {
            iMidudu.Lucky.Web.BizWebService.SaveWXUserRequest inValue = new iMidudu.Lucky.Web.BizWebService.SaveWXUserRequest();
            inValue.Body = new iMidudu.Lucky.Web.BizWebService.SaveWXUserRequestBody();
            inValue.Body.user = user;
            iMidudu.Lucky.Web.BizWebService.SaveWXUserResponse retVal = ((iMidudu.Lucky.Web.BizWebService.BizWebServiceSoap)(this)).SaveWXUser(inValue);
        }
    }
}

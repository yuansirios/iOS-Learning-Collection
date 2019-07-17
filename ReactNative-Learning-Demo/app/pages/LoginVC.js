import React from "react";
import { 
  View, 
  Text,
  Button,
  Alert,
  TextInput,
  StyleSheet
} from 'react-native';

export default class LoginVC extends React.Component {

  constructor(props){
    super(props);
    this.state = {
        accountValue:'',
        passwordValue:'',
    }

    //将全局的this绑定到_onChangeAccountText函数
    this._onChangeAccountText=this._onChangeAccountText.bind(this)
  }

  _onChangeAccountText(inputData){
    this.state.accountValue = inputData;
  }

  buttonClick = () => {
    let str = "用户名："+this.state.accountValue+"\n密码："+this.state.passwordValue;
    Alert.alert(str);
  };

  render() {
    return (
      <View style={styles.container}>
        {/* 图标 */}
        <View style={styles.topContainer}>
            <View style={styles.iconImage}></View>
        </View>
        {/* 输入信息 */}
        <View style={styles.inputContainer}>
          {/* 用户名 */}
          <View style={styles.inputAccount}>
              <Text style={styles.inputLabelStyle}>用户名：</Text>
              <TextInput 
              style={styles.inputContentStyle} 
              onChangeText={this._onChangeAccountText}/>
          </View>
          {/* 密码 */}
          <View style={styles.inputAccount}>
              <Text style={styles.inputLabelStyle}>密码：</Text>
              <TextInput 
              style={styles.inputContentStyle} 
              onChangeText={(text) => {
              this.state.passwordValue = text}}
              password="true"/>
          </View>
        </View>

        <View style={{
          margin: 10,
          height: 40,
          marginTop:40,
          backgroundColor: '#E6E6FA',
          borderRadius: 10,
          borderWidth: 1,
          borderColor: '#7FFF00'}}>
            
          <Button  style={{
          flex:1}}
          title={"登录"} 
          color={'green'} 
          onPress={this.buttonClick}/>
        </View>
        
      </View>
    );
  } 
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "white",
    flexDirection:"column",
  },
  topContainer:{
    marginTop:100,
    height:100,
    backgroundColor: "yellow",
    alignItems:"center"
  },
  iconImage:{
    width:100,
    height:100,
    backgroundColor: "green",
  },
  inputContainer:{
    marginTop:40,
    height:100,
    backgroundColor: "yellow",
  },
  inputAccount:{
    height:50,
    backgroundColor: "#998272",
    flexDirection:"row"
  },
  inputLabelStyle:{
    flex:1,
    backgroundColor:'#AAA',
    textAlign:'right',
    alignItems:'center',
    lineHeight: 50
  },
  inputContentStyle:{
    flex:3, 
    borderColor: 'red',
    borderWidth: 1,
    marginTop:5,
    marginBottom:5,
    marginRight:10
  }
});

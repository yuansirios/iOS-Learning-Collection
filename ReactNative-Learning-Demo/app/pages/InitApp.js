
import React from "react";
import {View, Text} from 'react-native';
import LoginVC from './LoginVC';
import FlexBox from '../FlexBox/FlexBox';

export default class InitApp extends React.Component {
  render() {
    return <FlexBox/>
    return (
      <View style={{ flex: 1, alignItems: "center", justifyContent: "center" }}>
        <Text>InitApp</Text>
      </View>
    );
  }
}
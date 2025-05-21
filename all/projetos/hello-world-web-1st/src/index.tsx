import React from 'react';
import { AppRegistry, Text, View } from 'react-native';
//import { name as appName } from '../package.json';
  const appName = 'HelloWebRN';

const App = () => (
  <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
    <Text>Hello World</Text>
  </View>
);

AppRegistry.registerComponent(appName, () => App);
AppRegistry.runApplication(appName, {
  rootTag: document.getElementById('root'),
});

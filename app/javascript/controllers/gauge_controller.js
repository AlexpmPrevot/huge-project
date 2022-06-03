import { Controller } from "stimulus"
import { cubicBezier, Gauge } from 'gauge-chart-js';
import gradstop from 'gradstop';
export default class extends Controller {
  static values = {
    color: String
  }
  connect() {
    const step = 70;
    const fromAngle = 0;
    const toAngle = 360;
    const maxValue = toAngle - fromAngle;
    let value = maxValue * 0.2;
    const container = this.element
    const sharedConfig = {
      lineWidth: 3,
      container,
      fromAngle,
      toAngle,
      easing: cubicBezier(0.165, 0.84, 0.44, 1)
    };
    const gaugeBackground = new Gauge({
      ...sharedConfig,
      color: '#F5F5F5'
    });
    gaugeBackground.setValue(maxValue);
    const gaugeMain = new Gauge({
      ...sharedConfig,
      colors: gradstop({
        stops: maxValue,
        colorArray: [this.colorValue, '#86A8E7', '#5FFBF1']
      })
    });
    gaugeMain.setValue(value);
  }
}

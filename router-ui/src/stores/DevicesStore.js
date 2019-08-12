import { observable, action } from 'mobx';
import { fetchData, sendData } from '../utils/restCalls';

const serverUrl = process.env.SERVER_URL;


export class UsersStore {

    @observable devices = [];

    @observable error = undefined;

    @observable isDevicesLoading = false;

    parseState(data) {
        const res = JSON.parse(data);
        if (res.data && res.data.availableMacs){
                this.devices = res.data.availableMacs;
        }
    }


    @action load() {
        this.isDevicesLoading = true;
        fetchData(`${serverUrl}ui/presenceMobiles`).then(action(({ data }) => {
            this.parseState(data);
        })).catch(
            action(({ data }) => {
                this.error = data;
            }),
        ).finally(action(() => {
            this.isDevicesLoading = false;
        }));
    }


}

export default new UsersStore();

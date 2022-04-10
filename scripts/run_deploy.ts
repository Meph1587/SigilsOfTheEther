
import {deployConfig} from "./deployment/define-0-deploy-config";
import {deployContracts} from "./deployment/define-1-deploy-contracts";

deployConfig(process.env.DEPLOYER_ADDRESS)
.then(c => deployContracts(c))
//.then(c => mintQuests(c))
.catch(error => {
    console.error(error);
    process.exit(1);
});



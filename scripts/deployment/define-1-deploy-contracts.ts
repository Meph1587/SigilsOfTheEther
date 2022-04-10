import {DeployConfig} from "./define-0-deploy-config";
import {deployContract} from "../../helpers/deploy"

import {
    SigilsOfTheEther,
} from "../../typechain";


export async function deployContracts(c: DeployConfig): Promise<DeployConfig> {
    console.log(`\n --- DEPLOY ---`);

    const contract = await deployContract('SigilsOfTheEther') as SigilsOfTheEther;
    console.log(`SigilsOfTheEther deployed to: ${contract.address.toLowerCase()}`);

    return c;
}



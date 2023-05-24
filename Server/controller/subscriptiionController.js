const subscription = require("../Models/Subscription");

const newSubscription=async(req,res)=>{
     try{
        const{Email}=req.body;
        let subscribe= new subscription(req.body);
        await subscribe.save();
        console.log("newDsata os ", subscribe);

        res.status(200).json(subscribe);
    }catch(error){
        res.status(500).json({error:error.message})
     }
}

const subscriptionDetail=async(req,res)=>{
      try{
        const Email=req.params.Email;
        console.log(req.params.Email);
        const member=await subscription.findOne({Email});
        if(!member){
            res.status(400).send(json({msg:"error in finding subscription"}));
        }
        res.status(200).json({sDate:member.startDate,eDate:member.endDate});
    }catch(error){
        res.status(400).json({error:error.message})
    }
}

module.exports={newSubscription,subscriptionDetail};
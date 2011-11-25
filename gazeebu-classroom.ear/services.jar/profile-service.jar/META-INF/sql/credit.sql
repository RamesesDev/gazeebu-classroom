[cancelPendingOrder]
   UPDATE credit_order
   SET status = "CANCELLED"
   WHERE transactionid = $P{transactionid}
   AND objid = $P{objid}

[checkPendingOrder]
   SELECT * 
   FROM credit_order
   WHERE objid = $P{objid}
   AND status = "DRAFT" 

[updateorder]
   UPDATE credit_order
   SET status = "COMPLETED"
   WHERE transactionid = $P{transactionid}
   AND objid = $P{objid}

[verifytransactionid]
   SELECT * 
   FROM credit_order
   WHERE transactionid = $P{transactionid}

[inCredit]
   SELECT objid
   FROM credit
   WHERE objid = $P{objid}

[consumeCredit]
   UPDATE credit
   SET availablecredits = availablecredits - $P{value}
   WHERE objid = $P{objid}
   
[addCredit]
   UPDATE credit
   SET availablecredits = availablecredits + $P{value},
       totalcredits = totalcredits + $P{value}
   WHERE objid = $P{objid}

[createCreditAccount]
   INSERT INTO 
   credit (objid, totalcredits, availablecredits, totalconsumed, totalshared, totaldonated)
   VALUES ($P{objid}, 0, 0, 0, 0, 0)

[getCredits]
   SELECT *
   FROM credit
   WHERE objid = $P{objid}

[deductCreditShareFrom]
   UPDATE credit
   SET availablecredits = availablecredits - $P{amount},
       totalshared = totalshared + $P{amount}
   WHERE objid = $P{objid}

[addCreditShareTo]
   UPDATE credit
   SET availablecredits = availablecredits + $P{amount},
       totalcredits = totalcredits + $P{amount}
   WHERE objid = $P{objid}

[deductCreditDonationFrom]
   UPDATE credit
   SET availablecredits = availablecredits - $P{amount},
       totaldonated = totaldonated + $P{amount}
   WHERE objid = $P{objid}
   
[addCreditDonationTo]
   UPDATE credit
   SET availablecredits = availablecredits + $P{amount},
       totalcredits = totalcredits + $P{amount}
   WHERE objid = $P{objid}

[addDonation]
   INSERT INTO credit_exception
   VALUES($P{objid}, $P{type}, $P{amount}, $P{amount})

[findDonation]
   SELECT *
   FROM credit_exception
   WHERE objid = $P{objid} 
   AND type = $P{type}
   
[udpateDonation]
   UPDATE credit_exception
   SET amount = amount + $P{amount},
       available = available + $P{amount}
   WHERE objid = $P{objid}
   AND type = $P{type}

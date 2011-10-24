[inquireBalance]
   SELECT c.availablecredits - ifnull(sum(ce.available), 0.00) AS available
   FROM credit c
   LEFT JOIN credit_exception ce ON c.objid = ce.objid AND ce.type <> $P{credittype}
   WHERE c.objid = $P{objid}
   GROUP BY ce.objid


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

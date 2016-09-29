# Elixir Home Security Network

### A home security network simulation built with Elixir

---

Approach:

* Each home security system on the network is a process that can hold state:
 * unarmed - breaching the premise does not cause an alarm to sound
 * armed - breaching the premise will cause an alarm to sound
 * breached - premise has been breached and alarm has been sounded
 * emergency (authorities alerted) - premise breached, alarm sounded AND incorrect code entered 3 times or over 60 seconds has elapsed without a correct code being entered

* Home security processes will be managed by a `GenServer`

* A supervisor must ensure that all registered processes are running and restart any that have been killed

* If a process has been killed and cannot be restarted (i.e. a burgular has cut the network connection), the supervisor must send a message (alerting the authorities)


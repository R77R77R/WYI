

export const checkDomain = (domain:string) => {
    return [domain].includes(window.location.hostname)
}

export const initHost = () => {
    const hostname = window.location.hostname

    const host: Host = {
        hostname: hostname,
        api: `${window.location.protocol}//${hostname}`,
        wsurl: `wss://${hostname}/ws/`,
        discordAPPID: "1254790111913181274",
        discordRedirect: `${window.location.protocol}//${window.location.host}/redirect/DISCORD`,
    }

    switch (host.hostname) {
        case 'localhost':
            host.hostname = 'localhost'
            host.api = 'https://localhost'
            host.wsurl = 'wss://localhost/'
            break
        case '127.0.0.1':
            host.hostname = '127.0.0.1'
            host.api = 'http://localhost'
            host.wsurl = 'wss://localhost/'
            break
    }
    console.log("host.hostname: " + host.hostname)
    console.log("host.api: " + host.api)
    console.log("host.wsurl: " + host.wsurl)

    return host
}

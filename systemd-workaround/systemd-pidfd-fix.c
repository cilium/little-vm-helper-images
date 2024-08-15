#define _GNU_SOURCE

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <spawn.h>
#include <sys/utsname.h>
#include <dlfcn.h>
#include <ctype.h>

int pidfd_spawn(int *restrict pidfd,
	const char *restrict file,
	const posix_spawn_file_actions_t *restrict facts,
	const posix_spawnattr_t *restrict attrp,
	char *const argv[restrict],
	char *const envp[restrict]);

int pidfd_spawn (int *restrict pidfd,
	const char *restrict file,
	const posix_spawn_file_actions_t *restrict facts,
	const posix_spawnattr_t *restrict attrp,
	char *const argv[restrict],
	char *const envp[restrict])
{
	struct utsname buff;
	if (uname(&buff) == 0) {
		long ver[16];
		int i = 0;
		char *p = buff.release;
		while (*p) {
        		if (isdigit(*p)) {
            			ver[i] = strtol(p, &p, 10);
            			i++;
        		} else {
            			p++;
        		}
    		}
		printf("%ld.%ld.%ld\n", ver[0], ver[1], ver[2]);
		if (ver[0] <= 5 && ver[0] < 7) {
			return ENOSYS;
		}
	}

	typeof(pidfd_spawn) *f = dlsym(RTLD_NEXT, "pidfd_spawn");
	if (!f) {
		return EINVAL;
	}

	return f(pidfd, file, facts, attrp, argv, envp);
}
